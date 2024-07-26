import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Color.fromARGB(255, 16, 114, 194),
      ),
      child: const SizedBox(
          width: 1500,
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }
}
