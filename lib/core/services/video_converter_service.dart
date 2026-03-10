import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

// Web用の条件付きインポート
import 'video_converter_web.dart' if (dart.library.io) 'video_converter_stub.dart';

/// 動画変換サービス
/// Web版ではFFmpeg.wasmを使ってMOV→MP4変換を行う
class VideoConverterService {
  /// FFmpegを初期化
  static Future<bool> initialize() async {
    if (!kIsWeb) return true;
    try {
      return await initFFmpegWeb();
    } catch (e) {
      print('FFmpeg initialization error: $e');
      return false;
    }
  }

  /// 動画をMP4に変換（必要な場合のみ）
  /// Web版でMOV等の非対応形式の場合、MP4に変換して返す
  /// 変換に失敗した場合は元のファイルをそのまま返す
  static Future<ConversionResult> convertIfNeeded({
    required Uint8List bytes,
    required String fileName,
    Function(int)? onProgress,
  }) async {
    if (!kIsWeb) {
      // モバイル版は変換不要
      return ConversionResult(
        bytes: bytes,
        fileName: fileName,
        wasConverted: false,
      );
    }

    // FFmpeg WASM変換は遅すぎるため無効化
    // MOVはそのままアップロードし、再生側で互換性を処理する
    // （Chrome非対応時は「Safariで開く」ボタンを表示）
    return ConversionResult(
      bytes: bytes,
      fileName: fileName,
      wasConverted: false,
    );
  }

  /// 変換が必要かどうかをチェック
  static bool needsConversion(String fileName) {
    if (!kIsWeb) return false;
    return needsConversionWeb(fileName);
  }
}

/// 変換結果
class ConversionResult {
  final Uint8List bytes;
  final String fileName;
  final bool wasConverted;

  ConversionResult({
    required this.bytes,
    required this.fileName,
    required this.wasConverted,
  });
}
