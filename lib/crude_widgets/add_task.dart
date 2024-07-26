import 'package:flutter/material.dart';
import 'package:ordernow/Controller/firebasecontroller.dart';
import 'package:ordernow/notifications/notifications.dart';
import 'package:ordernow/screens/tasks/tasks.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddTask extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AddTask({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  AddTaskState createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final DateTime scheduledStartDateTime = DateTime(2050);
  DateTime? scheduledEndDateTime;
  String? _selectedCategory;

  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;

  final List<String> _categories = ['Work', 'Personal', 'Home', 'Others'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeNotifications();
    requestExactAlarmPermission();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Task',
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
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
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

              scheduleNotification(_titleController.text, scheduledDateTime);
              createTask(
                  _titleController.text, scheduledDateTime, scheduledDateTime);
              // Save task logic here
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
