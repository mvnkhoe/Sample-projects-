import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasontime/screens/reminder/reminderr.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialization
void initializeNotifications(BuildContext context) {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      onSelectNotification(response.payload, context);
    },
  );
}

Future<void> initNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// On select action
Future<void> onSelectNotification(String? payload, BuildContext context) async {
  if (payload != null) {
    print('Notification payload: $payload');
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Reminder()));
  }
}

Future<void> requestExactAlarmPermission(BuildContext context) async {
  if (await Permission.scheduleExactAlarm.request().isGranted &&
      await Permission.notification.request().isGranted) {
    print("Exact alarm and notification permissions granted");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Exact alarm and notification permissions granted")),
    );
  } else {
    print("Exact alarm or notification permission not granted");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Exact alarm or notification permission not granted")),
    );
  }
}

// Scheduling method with custom notification sound, vibration, and duration
Future<void> scheduleNotification(
    String title, DateTime notificationDateTime, BuildContext context) async {
  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      'Do: $title',
      tz.TZDateTime.from(notificationDateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel_id',
          'Reminder Notifications',
          channelDescription: 'Channel for reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm_sound'),
          playSound: true,
          enableVibration: true,
         
          timeoutAfter: 20000, // 20 seconds in mill/iseconds
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Notification scheduled for $title")),
    );
  } catch (e) {
    print("Error scheduling notification: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error scheduling notification")),
    );
  }
}
