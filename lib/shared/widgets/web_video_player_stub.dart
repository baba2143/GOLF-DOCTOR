import 'package:flutter/material.dart';

/// モバイル用のスタブ（Webでのみ使用されるため、ここでは空の実装）
class WebVideoPlayer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // モバイルでは使用されない
    return const SizedBox.shrink();
  }
}
