import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/models/points.dart';

final pointsRepositoryProvider = Provider<PointsRepository>((ref) {
  return PointsRepository();
});

class PointsRepository {
  final _client = SupabaseService.client;

  /// Get current point balance
  Future<int> getBalance() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('point_balances')
        .select('balance')
        .eq('user_id', userId)
        .single();

    return response['balance'] as int;
  }

  /// Get point balance object
  Future<PointBalance> getPointBalance() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('point_balances')
        .select()
        .eq('user_id', userId)
        .single();

    return PointBalance.fromJson(response);
  }

  /// Get transaction history
  Future<List<PointTransaction>> getTransactions({int limit = 50}) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('point_transactions')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => PointTransaction.fromJson(json))
        .toList();
  }

  /// Create Stripe checkout session for point purchase
  Future<String> createCheckoutSession({
    required PointPackage package,
  }) async {
    final response = await _client.functions.invoke(
      'purchase-points',
      body: {
        'points': package.points,
        'bonus_points': package.bonusPoints,
        'price_jpy': package.priceJpy,
        'stripe_price_id': package.stripePriceId,
      },
    );

    if (response.status != 200) {
      throw Exception(response.data['error'] ?? 'Failed to create checkout session');
    }

    return response.data['checkout_url'] as String;
  }
}
