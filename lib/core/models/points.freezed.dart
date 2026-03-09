// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointBalance _$PointBalanceFromJson(Map<String, dynamic> json) {
  return _PointBalance.fromJson(json);
}

/// @nodoc
mixin _$PointBalance {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  int get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PointBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointBalanceCopyWith<PointBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointBalanceCopyWith<$Res> {
  factory $PointBalanceCopyWith(
    PointBalance value,
    $Res Function(PointBalance) then,
  ) = _$PointBalanceCopyWithImpl<$Res, PointBalance>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    int balance,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$PointBalanceCopyWithImpl<$Res, $Val extends PointBalance>
    implements $PointBalanceCopyWith<$Res> {
  _$PointBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointBalanceImplCopyWith<$Res>
    implements $PointBalanceCopyWith<$Res> {
  factory _$$PointBalanceImplCopyWith(
    _$PointBalanceImpl value,
    $Res Function(_$PointBalanceImpl) then,
  ) = __$$PointBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    int balance,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$PointBalanceImplCopyWithImpl<$Res>
    extends _$PointBalanceCopyWithImpl<$Res, _$PointBalanceImpl>
    implements _$$PointBalanceImplCopyWith<$Res> {
  __$$PointBalanceImplCopyWithImpl(
    _$PointBalanceImpl _value,
    $Res Function(_$PointBalanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PointBalanceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointBalanceImpl implements _PointBalance {
  const _$PointBalanceImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    required this.balance,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$PointBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointBalanceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final int balance;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PointBalance(id: $id, userId: $userId, balance: $balance, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointBalanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, balance, updatedAt);

  /// Create a copy of PointBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointBalanceImplCopyWith<_$PointBalanceImpl> get copyWith =>
      __$$PointBalanceImplCopyWithImpl<_$PointBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointBalanceImplToJson(this);
  }
}

abstract class _PointBalance implements PointBalance {
  const factory _PointBalance({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    required final int balance,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$PointBalanceImpl;

  factory _PointBalance.fromJson(Map<String, dynamic> json) =
      _$PointBalanceImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  int get balance;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of PointBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointBalanceImplCopyWith<_$PointBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointTransaction _$PointTransactionFromJson(Map<String, dynamic> json) {
  return _PointTransaction.fromJson(json);
}

/// @nodoc
mixin _$PointTransaction {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_after')
  int get balanceAfter => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'stripe_payment_intent_id')
  String? get stripePaymentIntentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'related_diagnosis_id')
  String? get relatedDiagnosisId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PointTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointTransactionCopyWith<PointTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointTransactionCopyWith<$Res> {
  factory $PointTransactionCopyWith(
    PointTransaction value,
    $Res Function(PointTransaction) then,
  ) = _$PointTransactionCopyWithImpl<$Res, PointTransaction>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    TransactionType type,
    int amount,
    @JsonKey(name: 'balance_after') int balanceAfter,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'stripe_payment_intent_id') String? stripePaymentIntentId,
    @JsonKey(name: 'related_diagnosis_id') String? relatedDiagnosisId,
    String? description,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$PointTransactionCopyWithImpl<$Res, $Val extends PointTransaction>
    implements $PointTransactionCopyWith<$Res> {
  _$PointTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? expiresAt = freezed,
    Object? stripePaymentIntentId = freezed,
    Object? relatedDiagnosisId = freezed,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TransactionType,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            stripePaymentIntentId: freezed == stripePaymentIntentId
                ? _value.stripePaymentIntentId
                : stripePaymentIntentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedDiagnosisId: freezed == relatedDiagnosisId
                ? _value.relatedDiagnosisId
                : relatedDiagnosisId // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointTransactionImplCopyWith<$Res>
    implements $PointTransactionCopyWith<$Res> {
  factory _$$PointTransactionImplCopyWith(
    _$PointTransactionImpl value,
    $Res Function(_$PointTransactionImpl) then,
  ) = __$$PointTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    TransactionType type,
    int amount,
    @JsonKey(name: 'balance_after') int balanceAfter,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'stripe_payment_intent_id') String? stripePaymentIntentId,
    @JsonKey(name: 'related_diagnosis_id') String? relatedDiagnosisId,
    String? description,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$PointTransactionImplCopyWithImpl<$Res>
    extends _$PointTransactionCopyWithImpl<$Res, _$PointTransactionImpl>
    implements _$$PointTransactionImplCopyWith<$Res> {
  __$$PointTransactionImplCopyWithImpl(
    _$PointTransactionImpl _value,
    $Res Function(_$PointTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? expiresAt = freezed,
    Object? stripePaymentIntentId = freezed,
    Object? relatedDiagnosisId = freezed,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$PointTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TransactionType,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        stripePaymentIntentId: freezed == stripePaymentIntentId
            ? _value.stripePaymentIntentId
            : stripePaymentIntentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedDiagnosisId: freezed == relatedDiagnosisId
            ? _value.relatedDiagnosisId
            : relatedDiagnosisId // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointTransactionImpl implements _PointTransaction {
  const _$PointTransactionImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    required this.type,
    required this.amount,
    @JsonKey(name: 'balance_after') required this.balanceAfter,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'stripe_payment_intent_id') this.stripePaymentIntentId,
    @JsonKey(name: 'related_diagnosis_id') this.relatedDiagnosisId,
    this.description,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$PointTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointTransactionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final TransactionType type;
  @override
  final int amount;
  @override
  @JsonKey(name: 'balance_after')
  final int balanceAfter;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'stripe_payment_intent_id')
  final String? stripePaymentIntentId;
  @override
  @JsonKey(name: 'related_diagnosis_id')
  final String? relatedDiagnosisId;
  @override
  final String? description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'PointTransaction(id: $id, userId: $userId, type: $type, amount: $amount, balanceAfter: $balanceAfter, expiresAt: $expiresAt, stripePaymentIntentId: $stripePaymentIntentId, relatedDiagnosisId: $relatedDiagnosisId, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.stripePaymentIntentId, stripePaymentIntentId) ||
                other.stripePaymentIntentId == stripePaymentIntentId) &&
            (identical(other.relatedDiagnosisId, relatedDiagnosisId) ||
                other.relatedDiagnosisId == relatedDiagnosisId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    amount,
    balanceAfter,
    expiresAt,
    stripePaymentIntentId,
    relatedDiagnosisId,
    description,
    createdAt,
  );

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointTransactionImplCopyWith<_$PointTransactionImpl> get copyWith =>
      __$$PointTransactionImplCopyWithImpl<_$PointTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointTransactionImplToJson(this);
  }
}

abstract class _PointTransaction implements PointTransaction {
  const factory _PointTransaction({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    required final TransactionType type,
    required final int amount,
    @JsonKey(name: 'balance_after') required final int balanceAfter,
    @JsonKey(name: 'expires_at') final DateTime? expiresAt,
    @JsonKey(name: 'stripe_payment_intent_id')
    final String? stripePaymentIntentId,
    @JsonKey(name: 'related_diagnosis_id') final String? relatedDiagnosisId,
    final String? description,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$PointTransactionImpl;

  factory _PointTransaction.fromJson(Map<String, dynamic> json) =
      _$PointTransactionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  TransactionType get type;
  @override
  int get amount;
  @override
  @JsonKey(name: 'balance_after')
  int get balanceAfter;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'stripe_payment_intent_id')
  String? get stripePaymentIntentId;
  @override
  @JsonKey(name: 'related_diagnosis_id')
  String? get relatedDiagnosisId;
  @override
  String? get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointTransactionImplCopyWith<_$PointTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
