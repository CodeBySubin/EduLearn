
import 'package:flutter/material.dart';

IconWithColor getIconWithColor(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'malayalam':
        return IconWithColor(Icons.language, Colors.orange);
      case 'computer science':
        return IconWithColor(Icons.computer, Colors.blue);
      case 'mathematics':
        return IconWithColor(Icons.calculate, Colors.green);
      case 'chemistry':
        return IconWithColor(Icons.science, Colors.purple);
      case 'biology':
        return IconWithColor(Icons.biotech, Colors.teal);
      case 'physics':
        return IconWithColor(Icons.flash_on, Colors.red);
      default:
        return IconWithColor(Icons.book, Colors.grey);
    }
  }


class IconWithColor {
  final IconData icon;
  final Color color;

  IconWithColor(this.icon, this.color);
}


String getVideoThumbnail(String url) {
  if (url.contains('youtu')) {
    final id = _getYouTubeId(url);
    return 'https://img.youtube.com/vi/$id/0.jpg';
  } else if (url.contains('vimeo')) {
    final id = _getVimeoId(url);
    return 'https://vumbnail.com/$id.jpg';
  }
  throw Exception('Unsupported video URL');
}

String? _getYouTubeId(String url) {
  final match = RegExp(
    r'(?:v=|\/)([0-9A-Za-z_-]{11})(?:\?|&|$)',
  ).firstMatch(url);
  return match?.group(1);
}

String? _getVimeoId(String url) {
  final match = RegExp(
    r'vimeo\.com/(?:.*?/)?(\d+)',
  ).firstMatch(url);
  return match?.group(1);
}
