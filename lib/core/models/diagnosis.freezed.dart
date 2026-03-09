// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) {
  return _Diagnosis.fromJson(json);
}

/// @nodoc
mixin _$Diagnosis {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_id')
  String get proId => throw _privateConstructorUsedError;
  DiagnosisStatus get status => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'followup_count')
  int get followupCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_followups')
  int get maxFollowups => throw _privateConstructorUsedError;
  @JsonKey(name: 'deadline_at')
  DateTime get deadlineAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'answered_at')
  DateTime? get answeredAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError; // Joined data
  Profile? get user => throw _privateConstructorUsedError;
  Profile? get pro => throw _privateConstructorUsedError;
  @JsonKey(name: 'pro_profile')
  ProProfile? get proProfile => throw _privateConstructorUsedError;
  List<DiagnosisMessage>? get messages => throw _privateConstructorUsedError;

  /// Serializes this Diagnosis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosisCopyWith<Diagnosis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisCopyWith<$Res> {
  factory $DiagnosisCopyWith(Diagnosis value, $Res Function(Diagnosis) then) =
      _$DiagnosisCopyWithImpl<$Res, Diagnosis>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'pro_id') String proId,
    DiagnosisStatus status,
    int price,
    @JsonKey(name: 'followup_count') int followupCount,
    @JsonKey(name: 'max_followups') int maxFollowups,
    @JsonKey(name: 'deadline_at') DateTime deadlineAt,
    @JsonKey(name: 'answered_at') DateTime? answeredAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    Profile? user,
    Profile? pro,
    @JsonKey(name: 'pro_profile') ProProfile? proProfile,
    List<DiagnosisMessage>? messages,
  });

  $ProfileCopyWith<$Res>? get user;
  $ProfileCopyWith<$Res>? get pro;
  $ProProfileCopyWith<$Res>? get proProfile;
}

/// @nodoc
class _$DiagnosisCopyWithImpl<$Res, $Val extends Diagnosis>
    implements $DiagnosisCopyWith<$Res> {
  _$DiagnosisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? proId = null,
    Object? status = null,
    Object? price = null,
    Object? followupCount = null,
    Object? maxFollowups = null,
    Object? deadlineAt = null,
    Object? answeredAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? user = freezed,
    Object? pro = freezed,
    Object? proProfile = freezed,
    Object? messages = freezed,
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
            proId: null == proId
                ? _value.proId
                : proId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DiagnosisStatus,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            followupCount: null == followupCount
                ? _value.followupCount
                : followupCount // ignore: cast_nullable_to_non_nullable
                      as int,
            maxFollowups: null == maxFollowups
                ? _value.maxFollowups
                : maxFollowups // ignore: cast_nullable_to_non_nullable
                      as int,
            deadlineAt: null == deadlineAt
                ? _value.deadlineAt
                : deadlineAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            answeredAt: freezed == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as Profile?,
            pro: freezed == pro
                ? _value.pro
                : pro // ignore: cast_nullable_to_non_nullable
                      as Profile?,
            proProfile: freezed == proProfile
                ? _value.proProfile
                : proProfile // ignore: cast_nullable_to_non_nullable
                      as ProProfile?,
            messages: freezed == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<DiagnosisMessage>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get pro {
    if (_value.pro == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.pro!, (value) {
      return _then(_value.copyWith(pro: value) as $Val);
    });
  }

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProProfileCopyWith<$Res>? get proProfile {
    if (_value.proProfile == null) {
      return null;
    }

    return $ProProfileCopyWith<$Res>(_value.proProfile!, (value) {
      return _then(_value.copyWith(proProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiagnosisImplCopyWith<$Res>
    implements $DiagnosisCopyWith<$Res> {
  factory _$$DiagnosisImplCopyWith(
    _$DiagnosisImpl value,
    $Res Function(_$DiagnosisImpl) then,
  ) = __$$DiagnosisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'pro_id') String proId,
    DiagnosisStatus status,
    int price,
    @JsonKey(name: 'followup_count') int followupCount,
    @JsonKey(name: 'max_followups') int maxFollowups,
    @JsonKey(name: 'deadline_at') DateTime deadlineAt,
    @JsonKey(name: 'answered_at') DateTime? answeredAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    Profile? user,
    Profile? pro,
    @JsonKey(name: 'pro_profile') ProProfile? proProfile,
    List<DiagnosisMessage>? messages,
  });

  @override
  $ProfileCopyWith<$Res>? get user;
  @override
  $ProfileCopyWith<$Res>? get pro;
  @override
  $ProProfileCopyWith<$Res>? get proProfile;
}

/// @nodoc
class __$$DiagnosisImplCopyWithImpl<$Res>
    extends _$DiagnosisCopyWithImpl<$Res, _$DiagnosisImpl>
    implements _$$DiagnosisImplCopyWith<$Res> {
  __$$DiagnosisImplCopyWithImpl(
    _$DiagnosisImpl _value,
    $Res Function(_$DiagnosisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? proId = null,
    Object? status = null,
    Object? price = null,
    Object? followupCount = null,
    Object? maxFollowups = null,
    Object? deadlineAt = null,
    Object? answeredAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? user = freezed,
    Object? pro = freezed,
    Object? proProfile = freezed,
    Object? messages = freezed,
  }) {
    return _then(
      _$DiagnosisImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        proId: null == proId
            ? _value.proId
            : proId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DiagnosisStatus,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        followupCount: null == followupCount
            ? _value.followupCount
            : followupCount // ignore: cast_nullable_to_non_nullable
                  as int,
        maxFollowups: null == maxFollowups
            ? _value.maxFollowups
            : maxFollowups // ignore: cast_nullable_to_non_nullable
                  as int,
        deadlineAt: null == deadlineAt
            ? _value.deadlineAt
            : deadlineAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        answeredAt: freezed == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as Profile?,
        pro: freezed == pro
            ? _value.pro
            : pro // ignore: cast_nullable_to_non_nullable
                  as Profile?,
        proProfile: freezed == proProfile
            ? _value.proProfile
            : proProfile // ignore: cast_nullable_to_non_nullable
                  as ProProfile?,
        messages: freezed == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<DiagnosisMessage>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosisImpl implements _Diagnosis {
  const _$DiagnosisImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'pro_id') required this.proId,
    required this.status,
    required this.price,
    @JsonKey(name: 'followup_count') required this.followupCount,
    @JsonKey(name: 'max_followups') required this.maxFollowups,
    @JsonKey(name: 'deadline_at') required this.deadlineAt,
    @JsonKey(name: 'answered_at') this.answeredAt,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    this.user,
    this.pro,
    @JsonKey(name: 'pro_profile') this.proProfile,
    final List<DiagnosisMessage>? messages,
  }) : _messages = messages;

  factory _$DiagnosisImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'pro_id')
  final String proId;
  @override
  final DiagnosisStatus status;
  @override
  final int price;
  @override
  @JsonKey(name: 'followup_count')
  final int followupCount;
  @override
  @JsonKey(name: 'max_followups')
  final int maxFollowups;
  @override
  @JsonKey(name: 'deadline_at')
  final DateTime deadlineAt;
  @override
  @JsonKey(name: 'answered_at')
  final DateTime? answeredAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  // Joined data
  @override
  final Profile? user;
  @override
  final Profile? pro;
  @override
  @JsonKey(name: 'pro_profile')
  final ProProfile? proProfile;
  final List<DiagnosisMessage>? _messages;
  @override
  List<DiagnosisMessage>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Diagnosis(id: $id, userId: $userId, proId: $proId, status: $status, price: $price, followupCount: $followupCount, maxFollowups: $maxFollowups, deadlineAt: $deadlineAt, answeredAt: $answeredAt, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, pro: $pro, proProfile: $proProfile, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.proId, proId) || other.proId == proId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.followupCount, followupCount) ||
                other.followupCount == followupCount) &&
            (identical(other.maxFollowups, maxFollowups) ||
                other.maxFollowups == maxFollowups) &&
            (identical(other.deadlineAt, deadlineAt) ||
                other.deadlineAt == deadlineAt) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.pro, pro) || other.pro == pro) &&
            (identical(other.proProfile, proProfile) ||
                other.proProfile == proProfile) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    proId,
    status,
    price,
    followupCount,
    maxFollowups,
    deadlineAt,
    answeredAt,
    createdAt,
    updatedAt,
    user,
    pro,
    proProfile,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      __$$DiagnosisImplCopyWithImpl<_$DiagnosisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisImplToJson(this);
  }
}

abstract class _Diagnosis implements Diagnosis {
  const factory _Diagnosis({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'pro_id') required final String proId,
    required final DiagnosisStatus status,
    required final int price,
    @JsonKey(name: 'followup_count') required final int followupCount,
    @JsonKey(name: 'max_followups') required final int maxFollowups,
    @JsonKey(name: 'deadline_at') required final DateTime deadlineAt,
    @JsonKey(name: 'answered_at') final DateTime? answeredAt,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    final Profile? user,
    final Profile? pro,
    @JsonKey(name: 'pro_profile') final ProProfile? proProfile,
    final List<DiagnosisMessage>? messages,
  }) = _$DiagnosisImpl;

  factory _Diagnosis.fromJson(Map<String, dynamic> json) =
      _$DiagnosisImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'pro_id')
  String get proId;
  @override
  DiagnosisStatus get status;
  @override
  int get price;
  @override
  @JsonKey(name: 'followup_count')
  int get followupCount;
  @override
  @JsonKey(name: 'max_followups')
  int get maxFollowups;
  @override
  @JsonKey(name: 'deadline_at')
  DateTime get deadlineAt;
  @override
  @JsonKey(name: 'answered_at')
  DateTime? get answeredAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt; // Joined data
  @override
  Profile? get user;
  @override
  Profile? get pro;
  @override
  @JsonKey(name: 'pro_profile')
  ProProfile? get proProfile;
  @override
  List<DiagnosisMessage>? get messages;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiagnosisMessage _$DiagnosisMessageFromJson(Map<String, dynamic> json) {
  return _DiagnosisMessage.fromJson(json);
}

/// @nodoc
mixin _$DiagnosisMessage {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'diagnosis_id')
  String get diagnosisId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_type')
  MessageType get messageType => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String? get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError; // Joined
  Profile? get sender => throw _privateConstructorUsedError;

  /// Serializes this DiagnosisMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosisMessageCopyWith<DiagnosisMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisMessageCopyWith<$Res> {
  factory $DiagnosisMessageCopyWith(
    DiagnosisMessage value,
    $Res Function(DiagnosisMessage) then,
  ) = _$DiagnosisMessageCopyWithImpl<$Res, DiagnosisMessage>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'diagnosis_id') String diagnosisId,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'message_type') MessageType messageType,
    String? text,
    @JsonKey(name: 'video_url') String? videoUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
    Profile? sender,
  });

  $ProfileCopyWith<$Res>? get sender;
}

/// @nodoc
class _$DiagnosisMessageCopyWithImpl<$Res, $Val extends DiagnosisMessage>
    implements $DiagnosisMessageCopyWith<$Res> {
  _$DiagnosisMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diagnosisId = null,
    Object? senderId = null,
    Object? messageType = null,
    Object? text = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = null,
    Object? sender = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            diagnosisId: null == diagnosisId
                ? _value.diagnosisId
                : diagnosisId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            messageType: null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                      as MessageType,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sender: freezed == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as Profile?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiagnosisMessageImplCopyWith<$Res>
    implements $DiagnosisMessageCopyWith<$Res> {
  factory _$$DiagnosisMessageImplCopyWith(
    _$DiagnosisMessageImpl value,
    $Res Function(_$DiagnosisMessageImpl) then,
  ) = __$$DiagnosisMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'diagnosis_id') String diagnosisId,
    @JsonKey(name: 'sender_id') String senderId,
    @JsonKey(name: 'message_type') MessageType messageType,
    String? text,
    @JsonKey(name: 'video_url') String? videoUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
    Profile? sender,
  });

  @override
  $ProfileCopyWith<$Res>? get sender;
}

/// @nodoc
class __$$DiagnosisMessageImplCopyWithImpl<$Res>
    extends _$DiagnosisMessageCopyWithImpl<$Res, _$DiagnosisMessageImpl>
    implements _$$DiagnosisMessageImplCopyWith<$Res> {
  __$$DiagnosisMessageImplCopyWithImpl(
    _$DiagnosisMessageImpl _value,
    $Res Function(_$DiagnosisMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diagnosisId = null,
    Object? senderId = null,
    Object? messageType = null,
    Object? text = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = null,
    Object? sender = freezed,
  }) {
    return _then(
      _$DiagnosisMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        diagnosisId: null == diagnosisId
            ? _value.diagnosisId
            : diagnosisId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageType: null == messageType
            ? _value.messageType
            : messageType // ignore: cast_nullable_to_non_nullable
                  as MessageType,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sender: freezed == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as Profile?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosisMessageImpl implements _DiagnosisMessage {
  const _$DiagnosisMessageImpl({
    required this.id,
    @JsonKey(name: 'diagnosis_id') required this.diagnosisId,
    @JsonKey(name: 'sender_id') required this.senderId,
    @JsonKey(name: 'message_type') required this.messageType,
    this.text,
    @JsonKey(name: 'video_url') this.videoUrl,
    @JsonKey(name: 'created_at') required this.createdAt,
    this.sender,
  });

  factory _$DiagnosisMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisMessageImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'diagnosis_id')
  final String diagnosisId;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'message_type')
  final MessageType messageType;
  @override
  final String? text;
  @override
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  // Joined
  @override
  final Profile? sender;

  @override
  String toString() {
    return 'DiagnosisMessage(id: $id, diagnosisId: $diagnosisId, senderId: $senderId, messageType: $messageType, text: $text, videoUrl: $videoUrl, createdAt: $createdAt, sender: $sender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.diagnosisId, diagnosisId) ||
                other.diagnosisId == diagnosisId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sender, sender) || other.sender == sender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    diagnosisId,
    senderId,
    messageType,
    text,
    videoUrl,
    createdAt,
    sender,
  );

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosisMessageImplCopyWith<_$DiagnosisMessageImpl> get copyWith =>
      __$$DiagnosisMessageImplCopyWithImpl<_$DiagnosisMessageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisMessageImplToJson(this);
  }
}

abstract class _DiagnosisMessage implements DiagnosisMessage {
  const factory _DiagnosisMessage({
    required final String id,
    @JsonKey(name: 'diagnosis_id') required final String diagnosisId,
    @JsonKey(name: 'sender_id') required final String senderId,
    @JsonKey(name: 'message_type') required final MessageType messageType,
    final String? text,
    @JsonKey(name: 'video_url') final String? videoUrl,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    final Profile? sender,
  }) = _$DiagnosisMessageImpl;

  factory _DiagnosisMessage.fromJson(Map<String, dynamic> json) =
      _$DiagnosisMessageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'diagnosis_id')
  String get diagnosisId;
  @override
  @JsonKey(name: 'sender_id')
  String get senderId;
  @override
  @JsonKey(name: 'message_type')
  MessageType get messageType;
  @override
  String? get text;
  @override
  @JsonKey(name: 'video_url')
  String? get videoUrl;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt; // Joined
  @override
  Profile? get sender;

  /// Create a copy of DiagnosisMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisMessageImplCopyWith<_$DiagnosisMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
