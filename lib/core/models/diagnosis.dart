import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'profile.dart';

part 'diagnosis.freezed.dart';
part 'diagnosis.g.dart';

enum DiagnosisStatus {
  pending,
  answered,
  @JsonValue('in_progress')
  inProgress,
  expired,
  refunded
}

enum MessageType {
  initial,
  answer,
  followup,
  @JsonValue('followup_answer')
  followupAnswer
}

@freezed
class Diagnosis with _$Diagnosis {
  const factory Diagnosis({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'pro_id') required String proId,
    required DiagnosisStatus status,
    required int price,
    @JsonKey(name: 'followup_count') required int followupCount,
    @JsonKey(name: 'max_followups') required int maxFollowups,
    @JsonKey(name: 'deadline_at') required DateTime deadlineAt,
    @JsonKey(name: 'answered_at') DateTime? answeredAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    // Joined data
    Profile? user,
    Profile? pro,
    @JsonKey(name: 'pro_profile') ProProfile? proProfile,
    List<DiagnosisMessage>? messages,
  }) = _Diagnosis;

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);
}

@freezed
class DiagnosisMessage with _$DiagnosisMessage {
  const factory DiagnosisMessage({
    required String id,
    @JsonKey(name: 'diagnosis_id') required String diagnosisId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'message_type') required MessageType messageType,
    String? text,
    @JsonKey(name: 'video_url') String? videoUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Joined
    Profile? sender,
  }) = _DiagnosisMessage;

  factory DiagnosisMessage.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisMessageFromJson(json);
}
