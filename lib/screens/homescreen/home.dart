import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../crude_widgets/add_task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasontime',
          style: TextStyle(fontFamily: 'serif', color: Colors.white),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 114, 194),
                Color.fromARGB(255, 90, 167, 230),
                Color.fromARGB(255, 94, 174, 240),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Set drawer icon color to white
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 114, 194),
              Color.fromARGB(255, 90, 167, 230),
              Color.fromARGB(255, 94, 174, 240),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Color.fromARGB(255, 114, 186, 240),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                  fontSize: 20,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategory('Personal', Icons.person_3_outlined),
                  _buildCategory('Work', Icons.work_outline),
                  _buildCategory('Others', Icons.more_outlined),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: selectedCategory != null
                    ? _buildTasksList()
                    : _buildPlaceholder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 114, 194),
                Color.fromARGB(255, 90, 167, 230),
                Color.fromARGB(255, 94, 174, 240),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      // drawer: _buildDrawer(),
    );
  }

  Widget _buildCategory(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = title;
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('category', isEqualTo: selectedCategory)
          .where('completed', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No tasks available'));
        }
        final tasks = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks for $selectedCategory',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final taskTitle = task['title'] as String;
                  final isCompleted = task['completed'] as bool;
                  final startTime = (task['startTime'] as Timestamp).toDate();

                  return GestureDetector(
                    onLongPress: () {
                      _showTaskDetailsDialog(task);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          taskTitle,
                          style: TextStyle(
                            fontSize: 16,
                            decoration:
                                isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: Checkbox(
                          value: isCompleted,
                          onChanged: (bool? value) {
                            if (value != null) {
                              // Check if current time is after start time
                              if (DateTime.now().isAfter(startTime)) {
                                _markTaskAsCompleted(task.id);
                              } else {
                                // Notify user or handle differently if needed
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Cannot mark as complete before start time',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        onTap: () {
                          // Handle tapping on a task item
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _markTaskAsCompleted(String taskId) {
    FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'completed': true,
    });
  }

  void _showTaskDetailsDialog(QueryDocumentSnapshot task) {
    DateTime startTime = (task['startTime'] as Timestamp).toDate();
    DateTime endTime = (task['endTime'] as Timestamp).toDate();
    String formattedStartTime = DateFormat.jm().format(startTime);
    String formattedEndTime = DateFormat.jm().format(endTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            task['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow('Category:', task['category']),
                _buildDetailRow('Start Time:', formattedStartTime),
                _buildDetailRow('End Time:', formattedEndTime),
                _buildDetailRow('Completed:', task['completed'] ? 'Yes' : 'No'),
                // Add more details here as needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: SingleChildScrollView(
          child: AddTask(
            scaffoldKey: GlobalKey<ScaffoldState>(),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        'Select a category to view tasks',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 114, 194),
              Color.fromARGB(255, 90, 167, 230),
              Color.fromARGB(255, 94, 174, 240),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 35,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tau Lekhotla',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'tau@gmail.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add_task_outlined,
                          color: Colors.blue),
                      title: const Text('Add Task'),
                      onTap: () {
                        _showAddTaskModal(context);
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.share_outlined, color: Colors.blue),
                      title: const Text('Share Task'),
                      onTap: () {
                        // Handle Share Task tap
                      },
                    ),
                    const Divider(
                      color: Colors.black38,
                      height: 20,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.blue),
                      title: const Text('Settings'),
                      onTap: () {
                        // Handle Settings tap
                      },
                    ),
                    const Spacer(),
                    const Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
