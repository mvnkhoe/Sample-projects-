import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasontime/firebase_api/firebase_api.dart';
import 'package:tasontime/notifications/notifications.dart';
import 'package:tasontime/screens/homescreen/homescreen.dart';
import 'package:tasontime/screens/login&signin/loginScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'models/task.dart';
import 'screens/reminder/reminderr.dart';
import 'package:tasontime/firebase_options.dart';

// import 'screens/homescreen/homescreen.dart';
// import 'screens/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TASONTIME',
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   initNotifications();
//   tz.initializeTimeZones();
//   tz.setLocalLocation(tz.getLocation('Africa/Maseru'));

//   runApp(MyApp());
// }

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     // onSelectNotification: (String? payload) {
//     //   // Handle notification tap
//     //   return null;
//     // },
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Demo Home Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: scheduleNotification,
//           child: Text('Schedule Notification'),
//         ),
//       ),
//     );
//   }
// }

// Future<void> scheduleNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'channel_id', // Replace with your channel ID
//     'Channel Name',

//     importance: Importance.max,
//     priority: Priority.high,
//     showWhen: false,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Scheduled Notification',
//     'This is the notification body.',
//     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//     platformChannelSpecifics,
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//   );
// }
