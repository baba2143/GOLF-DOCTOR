// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

/// Web専用の動画プレイヤー
class WebVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool showControls;

  const WebVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = false,
    this.showControls = true,
  });

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late String _viewId;
  html.VideoElement? _videoElement;
  bool _hasError = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _viewId = 'video-${DateTime.now().millisecondsSinceEpoch}';
    _setupVideo();
  }

  void _setupVideo() {
    _videoElement = html.VideoElement()
      ..src = widget.videoUrl
      ..autoplay = widget.autoPlay
      ..controls = widget.showControls
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain'
      ..style.backgroundColor = 'black';

    _videoElement!.setAttribute('playsinline', 'true');

    _videoElement!.onCanPlay.listen((_) {
      print('Video can play');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });

    _videoElement!.onError.listen((_) {
      final error = _videoElement!.error;
      print('Video error: ${error?.code} - ${error?.message}');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = _getErrorMessage(error?.code);
        });
      }
    });

    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int id) => _videoElement!,
    );
  }

  String _getErrorMessage(int? code) {
    switch (code) {
      case 4:
        return 'この動画形式はサポートされていません';
      case 3:
        return '動画のデコードに失敗しました';
      case 2:
        return 'ネットワークエラー';
      default:
        return '動画を読み込めませんでした';
    }
  }

  void _openInNewTab() {
    html.window.open(widget.videoUrl, '_blank');
  }

  @override
  void dispose() {
    _videoElement?.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.videocam_off, color: Colors.orange, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage ?? '動画を再生できません',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _openInNewTab,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Safariで開く'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Safari/iPhoneでは再生可能です',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        HtmlElementView(viewType: _viewId),
        if (_isLoading)
          Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
