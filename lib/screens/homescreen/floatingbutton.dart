import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 16, 114, 194),
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: const Color.fromARGB(255, 16, 114, 194),
      ),
    );
  }
}
