// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  id: json['id'] as String,
  diagnosisId: json['diagnosis_id'] as String,
  userId: json['user_id'] as String,
  proId: json['pro_id'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  user: json['user'] == null
      ? null
      : Profile.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diagnosis_id': instance.diagnosisId,
      'user_id': instance.userId,
      'pro_id': instance.proId,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };
