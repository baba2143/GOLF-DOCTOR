import 'dart:typed_data';

/// FFmpegを初期化（モバイル版スタブ）
Future<bool> initFFmpegWeb() async {
  // モバイル版では不要
  return true;
}

/// 動画をMP4に変換（モバイル版スタブ）
Future<Uint8List> convertToMp4Web(
  Uint8List bytes,
  String fileName,
  Function(int)? onProgress,
) async {
  // モバイル版では変換不要
  return bytes;
}

/// 変換が必要かチェック（モバイル版スタブ）
bool needsConversionWeb(String fileName) {
  // モバイル版では変換不要
  return false;
}
