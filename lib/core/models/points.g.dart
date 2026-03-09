// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointBalanceImpl _$$PointBalanceImplFromJson(Map<String, dynamic> json) =>
    _$PointBalanceImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      balance: (json['balance'] as num).toInt(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PointBalanceImplToJson(_$PointBalanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'balance': instance.balance,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$PointTransactionImpl _$$PointTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$PointTransactionImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  balanceAfter: (json['balance_after'] as num).toInt(),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  stripePaymentIntentId: json['stripe_payment_intent_id'] as String?,
  relatedDiagnosisId: json['related_diagnosis_id'] as String?,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$PointTransactionImplToJson(
  _$PointTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'balance_after': instance.balanceAfter,
  'expires_at': instance.expiresAt?.toIso8601String(),
  'stripe_payment_intent_id': instance.stripePaymentIntentId,
  'related_diagnosis_id': instance.relatedDiagnosisId,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$TransactionTypeEnumMap = {
  TransactionType.purchase: 'purchase',
  TransactionType.bonus: 'bonus',
  TransactionType.consume: 'consume',
  TransactionType.refund: 'refund',
  TransactionType.expire: 'expire',
};
