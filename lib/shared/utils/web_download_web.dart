// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web implementation - triggers browser download
void downloadFile(String url, String fileName) {
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..setAttribute('target', '_blank')
    ..click();
}
