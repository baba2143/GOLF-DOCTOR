import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/models/diagnosis.dart';

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return DiagnosisRepository();
});

class DiagnosisRepository {
  final _client = SupabaseService.client;

  /// Get diagnoses for current user (as patient or pro)
  Future<List<Diagnosis>> getUserDiagnoses() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('diagnoses')
        .select('*')
        .or('user_id.eq.$userId,pro_id.eq.$userId')
        .order('created_at', ascending: false);

    // Fetch profiles separately
    final diagnoses = <Diagnosis>[];
    for (final json in response as List) {
      // Get user profile
      final userResponse = await _client
          .from('profiles')
          .select('*')
          .eq('id', json['user_id'])
          .maybeSingle();

      // Get pro profile
      final proResponse = await _client
          .from('profiles')
          .select('*')
          .eq('id', json['pro_id'])
          .maybeSingle();

      diagnoses.add(Diagnosis.fromJson({
        ...json,
        'user': userResponse,
        'pro': proResponse,
      }));
    }

    return diagnoses;
  }

  /// Get single diagnosis with messages
  Future<Diagnosis?> getDiagnosis(String diagnosisId) async {
    final response = await _client
        .from('diagnoses')
        .select('''
          *,
          user:profiles!diagnoses_user_id_fkey(*),
          pro:profiles!diagnoses_pro_id_fkey(*),
          messages:diagnosis_messages(*, sender:profiles(*))
        ''')
        .eq('id', diagnosisId)
        .maybeSingle();

    if (response == null) return null;
    return Diagnosis.fromJson(response);
  }

  /// Create diagnosis via Edge Function
  Future<Diagnosis> createDiagnosis({
    required String proId,
    required int price,
    required String videoUrl,
    String? text,
  }) async {
    final response = await _client.functions.invoke(
      'create-diagnosis',
      body: {
        'pro_id': proId,
        'price': price,
        'video_url': videoUrl,
        'text': text,
      },
    );

    if (response.status != 200) {
      throw Exception(response.data['error'] ?? 'Failed to create diagnosis');
    }

    return Diagnosis.fromJson(response.data);
  }

  /// Add message to diagnosis
  Future<DiagnosisMessage> addMessage({
    required String diagnosisId,
    required MessageType messageType,
    String? text,
    String? videoUrl,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('diagnosis_messages')
        .insert({
          'diagnosis_id': diagnosisId,
          'sender_id': userId,
          'message_type': messageType.name,
          'text': text,
          'video_url': videoUrl,
        })
        .select('*, sender:profiles(*)')
        .single();

    // Update diagnosis status if this is an answer
    if (messageType == MessageType.answer) {
      await _client.from('diagnoses').update({
        'status': 'answered',
        'answered_at': DateTime.now().toIso8601String(),
      }).eq('id', diagnosisId);
    }

    // Update followup count if this is a followup
    if (messageType == MessageType.followup) {
      await _client.rpc('increment_followup_count', params: {
        'diagnosis_id': diagnosisId,
      });
    }

    return DiagnosisMessage.fromJson(response);
  }

  /// Upload video to storage
  Future<String> uploadVideo({
    required String filePath,
    required String diagnosisId,
  }) async {
    final userId = SupabaseService.currentUserId!;
    final fileName = '$diagnosisId/${DateTime.now().millisecondsSinceEpoch}.mp4';

    await _client.storage.from('videos').upload(
          '$userId/$fileName',
          _getFile(filePath),
        );

    return _client.storage.from('videos').getPublicUrl('$userId/$fileName');
  }

  dynamic _getFile(String path) {
    // This will be implemented with actual file handling
    throw UnimplementedError('Implement file handling');
  }
}
