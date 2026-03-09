import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/models/profile.dart';
import 'package:golf_doctor_app/core/models/review.dart';

final proRepositoryProvider = Provider<ProRepository>((ref) {
  return ProRepository();
});

class ProRepository {
  final _client = SupabaseService.client;

  /// Get list of approved and public pro profiles
  Future<List<ProProfile>> getPublicPros({
    String? specialty,
    String? sortBy,
  }) async {
    var query = _client
        .from('pro_profiles')
        .select('*, profile:profiles(*)')
        .eq('is_public', true)
        .eq('verification_status', 'approved');

    if (specialty != null) {
      query = query.contains('specialties', [specialty]);
    }

    final response = await query.order(
      sortBy ?? 'average_rating',
      ascending: false,
    );

    return (response as List).map((json) {
      final profileJson = json['profile'] as Map<String, dynamic>?;
      return ProProfile.fromJson({
        ...json,
        'profile': profileJson,
      });
    }).toList();
  }

  /// Get single pro profile by user ID
  Future<ProProfile?> getProProfile(String userId) async {
    final response = await _client
        .from('pro_profiles')
        .select('*, profile:profiles(*)')
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;

    final profileJson = response['profile'] as Map<String, dynamic>?;
    return ProProfile.fromJson({
      ...response,
      'profile': profileJson,
    });
  }

  /// Get reviews for a pro
  Future<List<Review>> getProReviews(String proId) async {
    final response = await _client
        .from('reviews')
        .select('*, user:profiles!reviews_user_id_fkey(*)')
        .eq('pro_id', proId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      final userJson = json['user'] as Map<String, dynamic>?;
      return Review.fromJson({
        ...json,
        'user': userJson,
      });
    }).toList();
  }

  /// Create or update pro profile
  Future<ProProfile> upsertProProfile({
    required String userId,
    String? bio,
    required int price,
    List<String>? specialties,
    List<String>? demoVideoUrls,
    String? idDocumentUrl,
    String? certificationUrl,
  }) async {
    final data = {
      'user_id': userId,
      'bio': bio,
      'price': price,
      'specialties': specialties,
      'demo_video_urls': demoVideoUrls,
      'id_document_url': idDocumentUrl,
      'certification_url': certificationUrl,
    };

    final response = await _client
        .from('pro_profiles')
        .upsert(data, onConflict: 'user_id')
        .select('*, profile:profiles(*)')
        .single();

    return ProProfile.fromJson(response);
  }

  /// Update profile to pro role
  Future<void> updateToProRole(String userId) async {
    await _client.from('profiles').update({'role': 'pro'}).eq('id', userId);
  }
}
