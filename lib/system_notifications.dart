import 'dart:async';

import 'package:flutter/services.dart';

class SystemNotifications {
  static const MethodChannel _channel =
      const MethodChannel('system_notifications');

  static Future<void> makeNotification({
    id: int,
    title: String,
    content: String,
    dismissible: bool
  }) async {
    await _channel.invokeMethod('makeNotification', {
      "id": id,
      "title": title,
      "content": content,
      "dismissible": dismissible,
    });
    return;
  }
}