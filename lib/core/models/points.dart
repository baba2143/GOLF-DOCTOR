import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'points.freezed.dart';
part 'points.g.dart';

enum TransactionType { purchase, bonus, consume, refund, expire }

@freezed
class PointBalance with _$PointBalance {
  const factory PointBalance({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required int balance,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PointBalance;

  factory PointBalance.fromJson(Map<String, dynamic> json) =>
      _$PointBalanceFromJson(json);
}

@freezed
class PointTransaction with _$PointTransaction {
  const factory PointTransaction({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required TransactionType type,
    required int amount,
    @JsonKey(name: 'balance_after') required int balanceAfter,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'stripe_payment_intent_id') String? stripePaymentIntentId,
    @JsonKey(name: 'related_diagnosis_id') String? relatedDiagnosisId,
    String? description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _PointTransaction;

  factory PointTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionFromJson(json);
}

/// Point package options for purchase
class PointPackage {
  final int points;
  final int bonusPoints;
  final int priceJpy;
  final String stripePriceId;

  const PointPackage({
    required this.points,
    required this.bonusPoints,
    required this.priceJpy,
    required this.stripePriceId,
  });

  int get totalPoints => points + bonusPoints;

  static const List<PointPackage> packages = [
    PointPackage(
      points: 1000,
      bonusPoints: 0,
      priceJpy: 1000,
      stripePriceId: 'price_1000',
    ),
    PointPackage(
      points: 3000,
      bonusPoints: 300,
      priceJpy: 3000,
      stripePriceId: 'price_3000',
    ),
    PointPackage(
      points: 5000,
      bonusPoints: 750,
      priceJpy: 5000,
      stripePriceId: 'price_5000',
    ),
    PointPackage(
      points: 10000,
      bonusPoints: 2000,
      priceJpy: 10000,
      stripePriceId: 'price_10000',
    ),
  ];
}
