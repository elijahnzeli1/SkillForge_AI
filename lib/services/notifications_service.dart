// ignore_for_file: deprecated_member_use

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationsService()
      : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // Handle iOS foreground notification
      },
    );

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Handle notification tapped logic here
      },
    );
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSNotificationDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showImmediateNotification(String title, String body) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSNotificationDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
