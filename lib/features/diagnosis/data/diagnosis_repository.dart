import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

    print('=== getUserDiagnoses called ===');

    final response = await _client
        .from('diagnoses')
        .select('*')
        .or('user_id.eq.$userId,pro_id.eq.$userId')
        .order('created_at', ascending: false);

    print('getUserDiagnoses response count: ${(response as List).length}');

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

    // デバッグログ
    print('=== getDiagnosis Debug ===');
    print('Response: $response');
    if (response != null && response['messages'] != null) {
      print('Messages: ${response['messages']}');
    }
    print('==========================');

    if (response == null) return null;
    return Diagnosis.fromJson(response);
  }

  /// Create diagnosis via Edge Function (本番用)
  Future<Diagnosis> createDiagnosisViaEdgeFunction({
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

  /// テスト用：直接DBに診断依頼を作成（Edge Function不要）
  /// ポイント消費 → 診断作成 → 初期メッセージ作成
  Future<Diagnosis> createDiagnosis({
    required String proId,
    required int price,
    required String videoUrl,
    String? text,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    // 1. ポイント残高確認
    final balanceResponse = await _client
        .from('point_balances')
        .select('balance')
        .eq('user_id', userId)
        .maybeSingle();

    final currentBalance = balanceResponse?['balance'] as int? ?? 0;
    if (currentBalance < price) {
      throw Exception('ポイントが不足しています（残高: $currentBalance, 必要: $price）');
    }

    // 2. ポイント消費
    final newBalance = currentBalance - price;
    await _client.from('point_balances').update({
      'balance': newBalance,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('user_id', userId);

    // 3. ポイント履歴に記録
    await _client.from('point_transactions').insert({
      'user_id': userId,
      'type': 'consume',
      'amount': -price,
      'balance_after': newBalance,
      'description': '診断依頼',
    });

    // 4. 診断を作成
    final deadline = DateTime.now().add(const Duration(hours: 48));
    final diagnosisResponse = await _client
        .from('diagnoses')
        .insert({
          'user_id': userId,
          'pro_id': proId,
          'status': 'pending',
          'price': price,
          'followup_count': 0,
          'max_followups': 3,
          'deadline_at': deadline.toIso8601String(),
        })
        .select()
        .single();

    final diagnosisId = diagnosisResponse['id'] as String;

    // 5. 初期メッセージを作成
    await _client.from('diagnosis_messages').insert({
      'diagnosis_id': diagnosisId,
      'sender_id': userId,
      'message_type': 'initial',
      'text': text,
      'video_url': videoUrl,
    });

    // 6. 完全な診断データを取得して返す
    final fullDiagnosis = await getDiagnosis(diagnosisId);
    if (fullDiagnosis == null) {
      throw Exception('Failed to retrieve created diagnosis');
    }
    return fullDiagnosis;
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

  /// Upload video to storage (supports both web and mobile)
  Future<String> uploadVideoBytes({
    required Uint8List bytes,
    required String fileName,
    String? diagnosisId,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // ファイル拡張子を取得（.mp4, .mov, .m4v など）
    final extension = fileName.split('.').last.toLowerCase();
    final validExtensions = ['mp4', 'mov', 'm4v', 'avi', 'webm'];
    final ext = validExtensions.contains(extension) ? extension : 'mp4';

    final storagePath = diagnosisId != null
        ? '$userId/$diagnosisId/$timestamp.$ext'
        : '$userId/temp/$timestamp.$ext';

    // デバッグログ（動画アップロード400エラー調査用）
    print('=== Video Upload Debug ===');
    print('Uploading to: $storagePath');
    print('Content-Type: ${_getContentType(ext)}');
    print('User ID: $userId');
    print('Bytes length: ${bytes.length}');
    print('File extension: $ext');
    print('==========================');

    await _client.storage.from('videos').uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: false,
            contentType: _getContentType(ext),
          ),
        );

    return _client.storage.from('videos').getPublicUrl(storagePath);
  }

  /// Upload video from file path (mobile only)
  Future<String> uploadVideo({
    required String filePath,
    String? diagnosisId,
  }) async {
    if (kIsWeb) {
      throw Exception('Use uploadVideoBytes for web platform');
    }

    // Dynamic import for mobile platforms only
    final bytes = await _readFileBytes(filePath);
    final fileName = filePath.split('/').last;
    return uploadVideoBytes(
      bytes: bytes,
      fileName: fileName,
      diagnosisId: diagnosisId,
    );
  }

  Future<Uint8List> _readFileBytes(String path) async {
    // This will only be called on mobile platforms
    final file = await _getFileFromPath(path);
    return file;
  }

  Future<Uint8List> _getFileFromPath(String path) async {
    // Use conditional import pattern
    throw UnimplementedError('Use uploadVideoBytes directly');
  }

  String _getContentType(String extension) {
    switch (extension) {
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'm4v':
        return 'video/x-m4v';
      case 'avi':
        return 'video/x-msvideo';
      case 'webm':
        return 'video/webm';
      default:
        return 'video/mp4';
    }
  }
}
