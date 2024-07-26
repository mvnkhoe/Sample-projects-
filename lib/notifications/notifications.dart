import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ordernow/screens/reminder/reminderr.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

var context;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void initializeNotifications() {
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

Future<void> onSelectNotification(String? payload, context) async {
  if (payload != null) {
    print('Notification payload: $payload');
    // Optionally navigate to a specific screen:
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Reminder()));
  }
}

Future<void> requestExactAlarmPermission() async {
  // Request permission for scheduling exact alarms
  final PermissionStatus status = await Permission.notification.request();
  if (status == PermissionStatus.granted) {
    print("Exact alarm permission granted");
  } else {
    print("Exact alarm permission not granted");
  }
}

Future<void> scheduleNotification(
    String title, DateTime notificationDateTime) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    'Do: $title',
    tz.TZDateTime.from(notificationDateTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exact,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
