import 'package:flutter/material.dart';
import '../../Controller/apptheme.dart';
import '../../Controller/firebasecontroller.dart';
import '../../theme/themecolor.dart';
import '../tasks/tasks.dart';
import 'btn.dart';
import 'loginScreen.dart';
import 'signup.dart';
import 'textform.dart';

class FormSection extends StatefulWidget {
  const FormSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.changeThemeCallback,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final VoidCallback changeThemeCallback;

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return formsection(context);
  }

  Expanded formsection(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: widget._formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter Password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                       const  Text(
                          "Have you signed up?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text(
                            "Signup",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 90, 167, 230),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (await readUserData(email.text, password.text)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Tasks()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Enter correct email and password!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: darkTheme
                            ? color2
                            : Color.fromARGB(255, 16, 114, 194),
                      ),
                      child: const SizedBox(
                        width: 1500,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          widget.changeThemeCallback();
                          setState(() {
                            darkTheme = !darkTheme;
                          });
                        },
                        child: darkTheme
                            ? Text("Light Theme")
                            : Text("Dark Theme"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
