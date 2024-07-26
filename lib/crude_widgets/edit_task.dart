import 'package:flutter/material.dart';
import 'package:tasontime/Controller/firebasecontroller.dart';

import 'package:tasontime/screens/tasks/tasks.dart';

class EditTask extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  String title;

  DateTime startime;

  String documentID;

  EditTask(
      {Key? key,
      required this.scaffoldKey,
      required this.title,
      required this.startime,
      required this.documentID});

  @override
  EditTaskState createState() => EditTaskState();
}

class EditTaskState extends State<EditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final DateTime scheduledStartDateTime = DateTime(2050);
  DateTime? scheduledEndDateTime;
  String? _selectedCategory;

  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;

  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.title;
    //i;lk_dateController.text = widget.startime as String;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Edit Task',
        style: TextStyle(color: Colors.blue),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _dateController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  });
                }
              },
            ),
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Start Time'),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedStartTime = pickedTime;
                    _startTimeController.text = pickedTime.format(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            if (_selectedDate != null && _selectedStartTime != null) {
              final DateTime scheduledDateTime = DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedStartTime!.hour,
                _selectedStartTime!.minute,
              );

              // updateTask(
              //     _titleController.text, scheduledDateTime, widget.documentID);
              // // Save task logic here
              Navigator.pop(context);

              // Show SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task added successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              // Show error message if date or time is not selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select both date and start time'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
