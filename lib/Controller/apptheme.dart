import 'package:flutter/material.dart';
import '../screens/login&signin/loginScreen.dart';

final GlobalKey<LoginScreenState> myKey = GlobalKey<LoginScreenState>();
BoxDecoration box1 = const BoxDecoration(
    gradient: LinearGradient(colors: [
  Color.fromARGB(255, 16, 114, 194),
  Color.fromARGB(255, 90, 167, 230),
  Color.fromARGB(255, 94, 174, 240)
]));
BoxDecoration box2 = const BoxDecoration(
    gradient: LinearGradient(colors: [
  Color.fromARGB(255, 0, 0, 0),
  Color.fromARGB(255, 19, 21, 22),
  Color.fromARGB(255, 39, 40, 41)
]));

theme() {
  myKey.currentState?.changeTheme();
}
