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
        .maybeSingle();

    if (response == null) return 0;
    return response['balance'] as int;
  }

  /// Get point balance object
  Future<PointBalance?> getPointBalance() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final response = await _client
        .from('point_balances')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
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

  /// テスト用：直接DBにポイントを追加（Edge Function不要）
  /// 本番ではStripe連携に置き換え
  Future<void> purchasePointsDirectly({
    required PointPackage package,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    final totalPoints = package.totalPoints;
    final expiresAt = DateTime.now().add(const Duration(days: 180)); // 6ヶ月有効

    // 現在の残高を取得（なければ0）
    int currentBalance = 0;
    try {
      final balanceResponse = await _client
          .from('point_balances')
          .select('balance')
          .eq('user_id', userId)
          .maybeSingle();

      if (balanceResponse != null) {
        currentBalance = balanceResponse['balance'] as int;
      }
    } catch (_) {
      // 残高レコードがない場合は0
    }

    final newBalance = currentBalance + totalPoints;

    // point_balances を upsert
    await _client.from('point_balances').upsert({
      'user_id': userId,
      'balance': newBalance,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id');

    // point_transactions に記録
    await _client.from('point_transactions').insert({
      'user_id': userId,
      'type': 'purchase',
      'amount': totalPoints,
      'balance_after': newBalance,
      'expires_at': expiresAt.toIso8601String(),
      'description': '${package.points}ポイント購入${package.bonusPoints > 0 ? ' (+${package.bonusPoints}ボーナス)' : ''}',
    });
  }
}
