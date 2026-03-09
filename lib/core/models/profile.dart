import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

enum UserRole { user, pro, admin }

enum UserStatus { active, suspended }

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required UserRole role,
    required UserStatus status,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@freezed
class ProProfile with _$ProProfile {
  const factory ProProfile({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    String? bio,
    required int price,
    List<String>? specialties,
    @JsonKey(name: 'demo_video_urls') List<String>? demoVideoUrls,
    @JsonKey(name: 'id_document_url') String? idDocumentUrl,
    @JsonKey(name: 'certification_url') String? certificationUrl,
    @JsonKey(name: 'verification_status') required VerificationStatus verificationStatus,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'is_public') required bool isPublic,
    @JsonKey(name: 'average_rating') required double averageRating,
    @JsonKey(name: 'review_count') required int reviewCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    // Joined from profiles
    Profile? profile,
  }) = _ProProfile;

  factory ProProfile.fromJson(Map<String, dynamic> json) =>
      _$ProProfileFromJson(json);
}

enum VerificationStatus { pending, approved, rejected }
