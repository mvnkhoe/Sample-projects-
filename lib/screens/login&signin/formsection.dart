import 'package:flutter/material.dart';

import 'btn.dart';
import 'textform.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: const SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          TextForm(),
                          SizedBox(
                            height: 20,
                          ),
                          TextForm(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Did you forget password?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 90, 167, 230),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Btn()
                        ])),
                  ),
                ))));
  }
}
