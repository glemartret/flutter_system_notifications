import 'package:flutter/material.dart';
import 'package:system_notifications/system_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Demo Notification'),
            onPressed: _makeNotification,
          ),
        ),
      ),
    );
  }

  void _makeNotification() async {
    await SystemNotifications.makeNotification(id: 1, title: "Example Title", content: "Example Content", dismissible: true);
  }
}