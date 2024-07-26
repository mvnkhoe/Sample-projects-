import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tasontime/notifications/notifications.dart';

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
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  String? _selectedCategory;
  bool _isPriority = false; // Added for priority setting
  bool _setReminder = false; // Added for reminder setting

  final List<String> _categories = ['Work', 'Personal', 'Home', 'Others'];

  @override
  void initState() {
    super.initState();
    initializeNotifications(context);
    requestExactAlarmPermission(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    super.dispose();
  }

  Future<void> _createTask(
      String title, DateTime start, DateTime end, String category) async {
    try {
      final DocumentReference documentReference =
          await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'startTime': Timestamp.fromDate(start),
        'endTime': Timestamp.fromDate(end),
        'completed': false,
        'category': category,
      });

      // If priority is set, update the document after creation
      if (_isPriority) {
        await documentReference.update({'priority': true});
      }

      _clearFields();
    } catch (e) {
      print('Error adding task to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding task: $e'),
        ),
      );
    }
  }

  void _clearFields() {
    _titleController.clear();
    _dateController.clear();
    _startTimeController.clear();
    setState(() {
      _selectedDate = null;
      _selectedStartTime = null;
      _selectedCategory = null;
      _isPriority = false; // Reset priority status
      _setReminder = false; // Reset reminder status
    });
  }

  void _onSavePressed() {
    if (_selectedDate != null &&
        _selectedStartTime != null &&
        _selectedCategory != null) {
      final DateTime scheduledDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedStartTime!.hour,
        _selectedStartTime!.minute,
      );

      if (_setReminder) {
        scheduleNotification(_titleController.text, scheduledDateTime, context);
      }

      _createTask(_titleController.text, scheduledDateTime, scheduledDateTime,
          _selectedCategory!);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
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
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(
                labelText: 'Start Time',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
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
            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _isPriority,
                      onChanged: (value) {
                        setState(() {
                          _isPriority = value!;
                        });
                      },
                    ),
                    const Text('Priority'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _setReminder,
                      onChanged: (value) {
                        setState(() {
                          _setReminder = value!;
                        });
                      },
                    ),
                    const Text('Reminder'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: _onSavePressed,
          child: Text('Save'),
        ),
      ],
    );
  }
}
