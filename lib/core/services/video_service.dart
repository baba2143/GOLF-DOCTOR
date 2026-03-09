import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/config/env_config.dart';

final videoServiceProvider = Provider<VideoService>((ref) {
  return VideoService();
});

class VideoService {
  final _picker = ImagePicker();
  final _storage = SupabaseService.storage;

  /// Pick video from gallery
  Future<XFile?> pickVideoFromGallery() async {
    return await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: EnvConfig.maxVideoDurationSeconds),
    );
  }

  /// Record video with camera
  Future<XFile?> recordVideo() async {
    return await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: EnvConfig.maxVideoDurationSeconds),
    );
  }

  /// Compress video before upload
  Future<File?> compressVideo(String filePath) async {
    try {
      final info = await VideoCompress.compressVideo(
        filePath,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
      );
      return info?.file;
    } catch (e) {
      print('Video compression failed: $e');
      return null;
    }
  }

  /// Get video file size in MB
  Future<double> getVideoSizeMB(String filePath) async {
    final file = File(filePath);
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }

  /// Upload video to Supabase Storage
  Future<String> uploadVideo({
    required String filePath,
    required String bucket,
    String? folder,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Not authenticated');

    // Check file size
    final sizeMB = await getVideoSizeMB(filePath);
    if (sizeMB > EnvConfig.maxVideoSizeMB) {
      throw Exception('動画サイズが大きすぎます（最大${EnvConfig.maxVideoSizeMB}MB）');
    }

    // Compress video
    File? compressedFile = await compressVideo(filePath);
    final uploadFile = compressedFile ?? File(filePath);

    // Generate unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final lastDot = filePath.lastIndexOf('.');
    final extension = lastDot != -1 ? filePath.substring(lastDot) : '.mp4';
    final fileName = folder != null
        ? '$userId/$folder/$timestamp$extension'
        : '$userId/$timestamp$extension';

    // Upload to storage
    await _storage.from(bucket).upload(
      fileName,
      uploadFile,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: false,
      ),
    );

    // Get public URL
    final publicUrl = _storage.from(bucket).getPublicUrl(fileName);

    // Clean up compressed file
    if (compressedFile != null && compressedFile.existsSync()) {
      await compressedFile.delete();
    }

    return publicUrl;
  }

  /// Upload diagnosis video
  Future<String> uploadDiagnosisVideo({
    required String filePath,
    required String diagnosisId,
  }) async {
    return uploadVideo(
      filePath: filePath,
      bucket: 'videos',
      folder: 'diagnoses/$diagnosisId',
    );
  }

  /// Upload demo video for pro profile
  Future<String> uploadDemoVideo({
    required String filePath,
  }) async {
    return uploadVideo(
      filePath: filePath,
      bucket: 'videos',
      folder: 'demos',
    );
  }

  /// Cancel compression
  Future<void> cancelCompression() async {
    await VideoCompress.cancelCompression();
  }

  /// Delete video from storage
  Future<void> deleteVideo(String videoUrl) async {
    try {
      // Extract path from URL
      final uri = Uri.parse(videoUrl);
      final pathSegments = uri.pathSegments;
      // Find the bucket and file path
      final bucketIndex = pathSegments.indexOf('object') + 2;
      if (bucketIndex < pathSegments.length) {
        final bucket = pathSegments[bucketIndex];
        final filePath = pathSegments.sublist(bucketIndex + 1).join('/');
        await _storage.from(bucket).remove([filePath]);
      }
    } catch (e) {
      print('Failed to delete video: $e');
    }
  }
}
