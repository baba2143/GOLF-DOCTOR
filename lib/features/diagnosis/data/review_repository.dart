import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/models/review.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

class ReviewRepository {
  final _client = SupabaseService.client;

  /// Create a review for a diagnosis
  Future<Review> createReview({
    required String diagnosisId,
    required String proId,
    required int rating,
    String? comment,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('reviews')
        .insert({
          'diagnosis_id': diagnosisId,
          'user_id': userId,
          'pro_id': proId,
          'rating': rating,
          'comment': comment,
        })
        .select()
        .single();

    return Review.fromJson(response);
  }

  /// Check if user already reviewed a diagnosis
  Future<bool> hasReviewed(String diagnosisId) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) return false;

    final response = await _client
        .from('reviews')
        .select('id')
        .eq('diagnosis_id', diagnosisId)
        .eq('user_id', userId)
        .maybeSingle();

    return response != null;
  }

  /// Get review for a diagnosis
  Future<Review?> getReviewForDiagnosis(String diagnosisId) async {
    final response = await _client
        .from('reviews')
        .select('*, user:profiles(*)')
        .eq('diagnosis_id', diagnosisId)
        .maybeSingle();

    if (response == null) return null;
    return Review.fromJson(response);
  }
}
