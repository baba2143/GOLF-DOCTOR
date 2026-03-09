// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiagnosisImpl _$$DiagnosisImplFromJson(Map<String, dynamic> json) =>
    _$DiagnosisImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      proId: json['pro_id'] as String,
      status: $enumDecode(_$DiagnosisStatusEnumMap, json['status']),
      price: (json['price'] as num).toInt(),
      followupCount: (json['followup_count'] as num).toInt(),
      maxFollowups: (json['max_followups'] as num).toInt(),
      deadlineAt: DateTime.parse(json['deadline_at'] as String),
      answeredAt: json['answered_at'] == null
          ? null
          : DateTime.parse(json['answered_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] == null
          ? null
          : Profile.fromJson(json['user'] as Map<String, dynamic>),
      pro: json['pro'] == null
          ? null
          : Profile.fromJson(json['pro'] as Map<String, dynamic>),
      proProfile: json['pro_profile'] == null
          ? null
          : ProProfile.fromJson(json['pro_profile'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => DiagnosisMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DiagnosisImplToJson(_$DiagnosisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'pro_id': instance.proId,
      'status': _$DiagnosisStatusEnumMap[instance.status]!,
      'price': instance.price,
      'followup_count': instance.followupCount,
      'max_followups': instance.maxFollowups,
      'deadline_at': instance.deadlineAt.toIso8601String(),
      'answered_at': instance.answeredAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user': instance.user,
      'pro': instance.pro,
      'pro_profile': instance.proProfile,
      'messages': instance.messages,
    };

const _$DiagnosisStatusEnumMap = {
  DiagnosisStatus.pending: 'pending',
  DiagnosisStatus.answered: 'answered',
  DiagnosisStatus.inProgress: 'in_progress',
  DiagnosisStatus.expired: 'expired',
  DiagnosisStatus.refunded: 'refunded',
};

_$DiagnosisMessageImpl _$$DiagnosisMessageImplFromJson(
  Map<String, dynamic> json,
) => _$DiagnosisMessageImpl(
  id: json['id'] as String,
  diagnosisId: json['diagnosis_id'] as String,
  senderId: json['sender_id'] as String,
  messageType: $enumDecode(_$MessageTypeEnumMap, json['message_type']),
  text: json['text'] as String?,
  videoUrl: json['video_url'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  sender: json['sender'] == null
      ? null
      : Profile.fromJson(json['sender'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DiagnosisMessageImplToJson(
  _$DiagnosisMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'diagnosis_id': instance.diagnosisId,
  'sender_id': instance.senderId,
  'message_type': _$MessageTypeEnumMap[instance.messageType]!,
  'text': instance.text,
  'video_url': instance.videoUrl,
  'created_at': instance.createdAt.toIso8601String(),
  'sender': instance.sender,
};

const _$MessageTypeEnumMap = {
  MessageType.initial: 'initial',
  MessageType.answer: 'answer',
  MessageType.followup: 'followup',
  MessageType.followupAnswer: 'followup_answer',
};
