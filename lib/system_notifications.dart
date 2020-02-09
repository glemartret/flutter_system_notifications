import 'dart:async';

import 'package:flutter/services.dart';

/// Flutter Plugin for System Notification
class SystemNotifications {
  /// Channel for native code communication
  static const MethodChannel _channel =
      const MethodChannel('system_notifications');

  /// Displays a System Notification with an [id], a [title], a [content] and a [dismissible]
  static Future<void> makeNotification(
      {id: int, title: String, content: String, dismissible: bool}) async {
    return await _channel.invokeMethod('makeNotification', {
      "id": id,
      "title": title,
      "content": content,
      "dismissible": dismissible,
    });
  }
}
