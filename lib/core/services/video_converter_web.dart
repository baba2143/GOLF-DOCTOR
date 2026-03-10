// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js_util' as js_util;

/// FFmpegを初期化（Web版）
Future<bool> initFFmpegWeb() async {
  try {
    print('Dart: Calling initFFmpegForDart...');

    // window.initFFmpegForDart() を呼び出し
    final initFn = js_util.getProperty(html.window, 'initFFmpegForDart');
    if (initFn == null) {
      print('initFFmpegForDart not found on window');
      return false;
    }

    final promise = js_util.callMethod(html.window, 'initFFmpegForDart', []);
    final result = await js_util.promiseToFuture(promise);
    print('Dart: initFFmpegForDart result: $result');
    return result == true;
  } catch (e) {
    print('Failed to initialize FFmpeg: $e');
    return false;
  }
}

/// 動画をMP4に変換（Web版）
Future<Uint8List> convertToMp4Web(
  Uint8List bytes,
  String fileName,
  Function(int)? onProgress,
) async {
  try {
    print('Dart: Starting video conversion...');

    // Reset progress
    try {
      js_util.callMethod(html.window, 'resetConversionProgressForDart', []);
    } catch (_) {}

    // Create Blob from bytes
    final blob = html.Blob([bytes], 'video/quicktime');
    print('Dart: Created blob, size: ${bytes.length}');

    // Start progress monitoring
    Timer? progressTimer;
    int lastReportedProgress = -1;
    if (onProgress != null) {
      progressTimer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
        try {
          final progress = js_util.callMethod(
              html.window, 'getConversionProgressForDart', []) as int?;
          if (progress != null && progress != lastReportedProgress) {
            lastReportedProgress = progress;
            onProgress(progress);
          }
        } catch (_) {}
      });
    }

    try {
      // Call conversion
      print('Dart: Calling convertVideoForDart...');
      final promise = js_util.callMethod(
          html.window, 'convertVideoForDart', [blob, fileName]);
      final result = await js_util.promiseToFuture(promise);
      print('Dart: Conversion complete');

      // Convert result to Uint8List
      final length = js_util.getProperty(result, 'length') as int;
      print('Dart: Result length: $length');

      final convertedBytes = Uint8List(length);
      for (var i = 0; i < length; i++) {
        convertedBytes[i] = js_util.getProperty(result, i) as int;
      }

      return convertedBytes;
    } finally {
      progressTimer?.cancel();
    }
  } catch (e) {
    print('Video conversion failed: $e');
    rethrow;
  }
}

/// 変換が必要かチェック（Web版）
bool needsConversionWeb(String fileName) {
  final ext = fileName.split('.').last.toLowerCase();
  // MOV and other non-MP4 formats need conversion for Chrome
  return ['mov', 'avi', 'wmv', 'mkv', 'webm', 'm4v'].contains(ext);
}
