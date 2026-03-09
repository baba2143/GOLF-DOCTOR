// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      fcmToken: json['fcm_token'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'status': _$UserStatusEnumMap[instance.status]!,
      'fcm_token': instance.fcmToken,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.pro: 'pro',
  UserRole.admin: 'admin',
};

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.suspended: 'suspended',
};

_$ProProfileImpl _$$ProProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProProfileImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bio: json['bio'] as String?,
      price: (json['price'] as num).toInt(),
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      demoVideoUrls: (json['demo_video_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      idDocumentUrl: json['id_document_url'] as String?,
      certificationUrl: json['certification_url'] as String?,
      verificationStatus: $enumDecode(
        _$VerificationStatusEnumMap,
        json['verification_status'],
      ),
      rejectionReason: json['rejection_reason'] as String?,
      isPublic: json['is_public'] as bool,
      averageRating: (json['average_rating'] as num).toDouble(),
      reviewCount: (json['review_count'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProProfileImplToJson(_$ProProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'bio': instance.bio,
      'price': instance.price,
      'specialties': instance.specialties,
      'demo_video_urls': instance.demoVideoUrls,
      'id_document_url': instance.idDocumentUrl,
      'certification_url': instance.certificationUrl,
      'verification_status':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
      'rejection_reason': instance.rejectionReason,
      'is_public': instance.isPublic,
      'average_rating': instance.averageRating,
      'review_count': instance.reviewCount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'profile': instance.profile,
    };

const _$VerificationStatusEnumMap = {
  VerificationStatus.pending: 'pending',
  VerificationStatus.approved: 'approved',
  VerificationStatus.rejected: 'rejected',
};
