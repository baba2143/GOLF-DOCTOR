import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'profile.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    @JsonKey(name: 'diagnosis_id') required String diagnosisId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'pro_id') required String proId,
    required int rating,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Joined
    Profile? user,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}
