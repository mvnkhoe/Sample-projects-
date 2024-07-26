import 'package:flutter/material.dart';
import '../../Controller/apptheme.dart';
import 'btn.dart';
import 'formsection.dart';
import 'textform.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool darkTheme = false;

  void changeTheme() {
    setState(() {
      darkTheme = !darkTheme;
    });
    print('Login Dark Theme $darkTheme');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 0),
        width: double.infinity,
        decoration: darkTheme ? box2 : box1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signin",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hello, Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FormSection(formKey: _formKey, changeThemeCallback: changeTheme),
          ],
        ),
      ),
    );
  }
}
