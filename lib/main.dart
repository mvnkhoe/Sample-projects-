import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ordernow/firebase_api/firebase_api.dart';
import 'package:ordernow/firebase_options.dart';
import 'package:ordernow/notifications/notifications.dart';
import 'package:ordernow/screens/homescreen/homescreen.dart';
import 'package:ordernow/screens/login&signin/loginScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'models/task.dart';
import 'screens/reminder/reminderr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TASONTIME',
      home: HomeScreen(),
    );
  }
}
