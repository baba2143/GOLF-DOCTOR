// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'fcm_token')
  String? get fcmToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({
    String id,
    String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    UserRole role,
    UserStatus status,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? fcmToken = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UserStatus,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
    _$ProfileImpl value,
    $Res Function(_$ProfileImpl) then,
  ) = __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    UserRole role,
    UserStatus status,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
    _$ProfileImpl _value,
    $Res Function(_$ProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? fcmToken = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UserStatus,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl({
    required this.id,
    required this.email,
    this.name,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    required this.role,
    required this.status,
    @JsonKey(name: 'fcm_token') this.fcmToken,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final UserRole role;
  @override
  final UserStatus status;
  @override
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Profile(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, role: $role, status: $status, fcmToken: $fcmToken, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    name,
    avatarUrl,
    role,
    status,
    fcmToken,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(this);
  }
}

abstract class _Profile implements Profile {
  const factory _Profile({
    required final String id,
    required final String email,
    final String? name,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    required final UserRole role,
    required final UserStatus status,
    @JsonKey(name: 'fcm_token') final String? fcmToken,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get name;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  UserRole get role;
  @override
  UserStatus get status;
  @override
  @JsonKey(name: 'fcm_token')
  String? get fcmToken;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProProfile _$ProProfileFromJson(Map<String, dynamic> json) {
  return _ProProfile.fromJson(json);
}

/// @nodoc
mixin _$ProProfile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  List<String>? get specialties => throw _privateConstructorUsedError;
  @JsonKey(name: 'demo_video_urls')
  List<String>? get demoVideoUrls => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_document_url')
  String? get idDocumentUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'certification_url')
  String? get certificationUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_status')
  VerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_public')
  bool get isPublic => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_count')
  int get reviewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError; // Joined from profiles
  Profile? get profile => throw _privateConstructorUsedError;

  /// Serializes this ProProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProProfileCopyWith<ProProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProProfileCopyWith<$Res> {
  factory $ProProfileCopyWith(
    ProProfile value,
    $Res Function(ProProfile) then,
  ) = _$ProProfileCopyWithImpl<$Res, ProProfile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String? bio,
    int price,
    List<String>? specialties,
    @JsonKey(name: 'demo_video_urls') List<String>? demoVideoUrls,
    @JsonKey(name: 'id_document_url') String? idDocumentUrl,
    @JsonKey(name: 'certification_url') String? certificationUrl,
    @JsonKey(name: 'verification_status') VerificationStatus verificationStatus,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'is_public') bool isPublic,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    Profile? profile,
  });

  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$ProProfileCopyWithImpl<$Res, $Val extends ProProfile>
    implements $ProProfileCopyWith<$Res> {
  _$ProProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bio = freezed,
    Object? price = null,
    Object? specialties = freezed,
    Object? demoVideoUrls = freezed,
    Object? idDocumentUrl = freezed,
    Object? certificationUrl = freezed,
    Object? verificationStatus = null,
    Object? rejectionReason = freezed,
    Object? isPublic = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? profile = freezed,
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
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            specialties: freezed == specialties
                ? _value.specialties
                : specialties // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            demoVideoUrls: freezed == demoVideoUrls
                ? _value.demoVideoUrls
                : demoVideoUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            idDocumentUrl: freezed == idDocumentUrl
                ? _value.idDocumentUrl
                : idDocumentUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            certificationUrl: freezed == certificationUrl
                ? _value.certificationUrl
                : certificationUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            verificationStatus: null == verificationStatus
                ? _value.verificationStatus
                : verificationStatus // ignore: cast_nullable_to_non_nullable
                      as VerificationStatus,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as Profile?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProProfileImplCopyWith<$Res>
    implements $ProProfileCopyWith<$Res> {
  factory _$$ProProfileImplCopyWith(
    _$ProProfileImpl value,
    $Res Function(_$ProProfileImpl) then,
  ) = __$$ProProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String? bio,
    int price,
    List<String>? specialties,
    @JsonKey(name: 'demo_video_urls') List<String>? demoVideoUrls,
    @JsonKey(name: 'id_document_url') String? idDocumentUrl,
    @JsonKey(name: 'certification_url') String? certificationUrl,
    @JsonKey(name: 'verification_status') VerificationStatus verificationStatus,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'is_public') bool isPublic,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    Profile? profile,
  });

  @override
  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$ProProfileImplCopyWithImpl<$Res>
    extends _$ProProfileCopyWithImpl<$Res, _$ProProfileImpl>
    implements _$$ProProfileImplCopyWith<$Res> {
  __$$ProProfileImplCopyWithImpl(
    _$ProProfileImpl _value,
    $Res Function(_$ProProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bio = freezed,
    Object? price = null,
    Object? specialties = freezed,
    Object? demoVideoUrls = freezed,
    Object? idDocumentUrl = freezed,
    Object? certificationUrl = freezed,
    Object? verificationStatus = null,
    Object? rejectionReason = freezed,
    Object? isPublic = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? profile = freezed,
  }) {
    return _then(
      _$ProProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        specialties: freezed == specialties
            ? _value._specialties
            : specialties // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        demoVideoUrls: freezed == demoVideoUrls
            ? _value._demoVideoUrls
            : demoVideoUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        idDocumentUrl: freezed == idDocumentUrl
            ? _value.idDocumentUrl
            : idDocumentUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        certificationUrl: freezed == certificationUrl
            ? _value.certificationUrl
            : certificationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        verificationStatus: null == verificationStatus
            ? _value.verificationStatus
            : verificationStatus // ignore: cast_nullable_to_non_nullable
                  as VerificationStatus,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as Profile?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProProfileImpl implements _ProProfile {
  const _$ProProfileImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    this.bio,
    required this.price,
    final List<String>? specialties,
    @JsonKey(name: 'demo_video_urls') final List<String>? demoVideoUrls,
    @JsonKey(name: 'id_document_url') this.idDocumentUrl,
    @JsonKey(name: 'certification_url') this.certificationUrl,
    @JsonKey(name: 'verification_status') required this.verificationStatus,
    @JsonKey(name: 'rejection_reason') this.rejectionReason,
    @JsonKey(name: 'is_public') required this.isPublic,
    @JsonKey(name: 'average_rating') required this.averageRating,
    @JsonKey(name: 'review_count') required this.reviewCount,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    this.profile,
  }) : _specialties = specialties,
       _demoVideoUrls = demoVideoUrls;

  factory _$ProProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String? bio;
  @override
  final int price;
  final List<String>? _specialties;
  @override
  List<String>? get specialties {
    final value = _specialties;
    if (value == null) return null;
    if (_specialties is EqualUnmodifiableListView) return _specialties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _demoVideoUrls;
  @override
  @JsonKey(name: 'demo_video_urls')
  List<String>? get demoVideoUrls {
    final value = _demoVideoUrls;
    if (value == null) return null;
    if (_demoVideoUrls is EqualUnmodifiableListView) return _demoVideoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'id_document_url')
  final String? idDocumentUrl;
  @override
  @JsonKey(name: 'certification_url')
  final String? certificationUrl;
  @override
  @JsonKey(name: 'verification_status')
  final VerificationStatus verificationStatus;
  @override
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  @override
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @override
  @JsonKey(name: 'average_rating')
  final double averageRating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  // Joined from profiles
  @override
  final Profile? profile;

  @override
  String toString() {
    return 'ProProfile(id: $id, userId: $userId, bio: $bio, price: $price, specialties: $specialties, demoVideoUrls: $demoVideoUrls, idDocumentUrl: $idDocumentUrl, certificationUrl: $certificationUrl, verificationStatus: $verificationStatus, rejectionReason: $rejectionReason, isPublic: $isPublic, averageRating: $averageRating, reviewCount: $reviewCount, createdAt: $createdAt, updatedAt: $updatedAt, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(
              other._specialties,
              _specialties,
            ) &&
            const DeepCollectionEquality().equals(
              other._demoVideoUrls,
              _demoVideoUrls,
            ) &&
            (identical(other.idDocumentUrl, idDocumentUrl) ||
                other.idDocumentUrl == idDocumentUrl) &&
            (identical(other.certificationUrl, certificationUrl) ||
                other.certificationUrl == certificationUrl) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    bio,
    price,
    const DeepCollectionEquality().hash(_specialties),
    const DeepCollectionEquality().hash(_demoVideoUrls),
    idDocumentUrl,
    certificationUrl,
    verificationStatus,
    rejectionReason,
    isPublic,
    averageRating,
    reviewCount,
    createdAt,
    updatedAt,
    profile,
  );

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProProfileImplCopyWith<_$ProProfileImpl> get copyWith =>
      __$$ProProfileImplCopyWithImpl<_$ProProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProProfileImplToJson(this);
  }
}

abstract class _ProProfile implements ProProfile {
  const factory _ProProfile({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    final String? bio,
    required final int price,
    final List<String>? specialties,
    @JsonKey(name: 'demo_video_urls') final List<String>? demoVideoUrls,
    @JsonKey(name: 'id_document_url') final String? idDocumentUrl,
    @JsonKey(name: 'certification_url') final String? certificationUrl,
    @JsonKey(name: 'verification_status')
    required final VerificationStatus verificationStatus,
    @JsonKey(name: 'rejection_reason') final String? rejectionReason,
    @JsonKey(name: 'is_public') required final bool isPublic,
    @JsonKey(name: 'average_rating') required final double averageRating,
    @JsonKey(name: 'review_count') required final int reviewCount,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    final Profile? profile,
  }) = _$ProProfileImpl;

  factory _ProProfile.fromJson(Map<String, dynamic> json) =
      _$ProProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String? get bio;
  @override
  int get price;
  @override
  List<String>? get specialties;
  @override
  @JsonKey(name: 'demo_video_urls')
  List<String>? get demoVideoUrls;
  @override
  @JsonKey(name: 'id_document_url')
  String? get idDocumentUrl;
  @override
  @JsonKey(name: 'certification_url')
  String? get certificationUrl;
  @override
  @JsonKey(name: 'verification_status')
  VerificationStatus get verificationStatus;
  @override
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason;
  @override
  @JsonKey(name: 'is_public')
  bool get isPublic;
  @override
  @JsonKey(name: 'average_rating')
  double get averageRating;
  @override
  @JsonKey(name: 'review_count')
  int get reviewCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt; // Joined from profiles
  @override
  Profile? get profile;

  /// Create a copy of ProProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProProfileImplCopyWith<_$ProProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
