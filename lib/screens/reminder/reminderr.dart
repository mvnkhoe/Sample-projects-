import 'package:flutter/material.dart';

import '../completedtasks/completedtasks.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return const CompletedTasks();
  }
}
