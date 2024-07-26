import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint;

  TextForm({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter $hint',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );
  }
}
