import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasontime/crude_widgets/add_task.dart';
import 'package:tasontime/models/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  List<String> list = <String>[
    'Category',
    'Date',
  ];
  String dropdownValue = 'Date';
  late CollectionReference<Map<String, dynamic>> tasksRef;

  @override
  void initState() {
    super.initState();
    tasksRef = FirebaseFirestore.instance.collection('tasks');
  }

  Map<DateTime, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final Map<DateTime, List<Task>> groupedTasks = {};

    for (var task in tasks) {
      final DateTime dateKey = DateTime(
        task.getStartTime.year,
        task.getStartTime.month,
        task.getStartTime.day,
      );

      if (!groupedTasks.containsKey(dateKey)) {
        groupedTasks[dateKey] = [];
      }

      groupedTasks[dateKey]!.add(task);
    }

    return groupedTasks;
  }

  Map<String, List<Task>> _groupTasksByCategory(List<Task> tasks) {
    final Map<String, List<Task>> groupedTasks = {};

    for (var task in tasks) {
      final categoryKey = task.getCategory;

      if (!groupedTasks.containsKey(categoryKey)) {
        groupedTasks[categoryKey.toString()] = [];
      }

      groupedTasks[categoryKey]!.add(task);
    }

    return groupedTasks;
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

  Future<void> _prioritizeTask(String taskId, bool currentPriority) async {
    try {
      await tasksRef.doc(taskId).update({'priority': !currentPriority});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task priority updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task priority: $e')),
      );
    }
  }

  void _editTask(Task task) {
    // Implement the logic to edit the task.
    // This might involve showing a modal with the current task details for editing.
  }

  void _setReminder(Task task) {
    // Implement the logic to set a reminder for the task.
    // This might involve using the notifications package.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: Container(
        padding: const EdgeInsets.only(bottom: 0),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 16, 114, 194),
            Color.fromARGB(255, 90, 167, 230),
            Color.fromARGB(255, 94, 174, 240),
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'serif',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat('EEE, M/d/y').format(DateTime.now()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'serif',
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showAddTaskModal(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 100,
                    height: 50,
                    child: const Icon(
                      Icons.add_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      tasksRef.where('completed', isEqualTo: false).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No tasks available'));
                    }

                    final tasks = snapshot.data!.docs
                        .map((doc) => Task(
                              doc.id,
                              doc['title'] as String,
                              (doc['startTime'] as Timestamp).toDate(),
                              (doc['endTime'] as Timestamp).toDate(),
                              doc['category'] as String,
                              // Add this line to handle priority
                            ))
                        .toList();

                    final groupedTasks = dropdownValue == 'Date'
                        ? _groupTasksByDate(tasks)
                        : _groupTasksByCategory(tasks);

                    return ListView.builder(
                      itemCount: groupedTasks.keys.length,
                      itemBuilder: (context, index) {
                        final groupKey = groupedTasks.keys.elementAt(index);
                        final groupTasks = groupedTasks[groupKey]!;

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.blue[50], // Background color
                          ),
                          child: Theme(
                            data: ThemeData(
                              dividerColor:
                                  Colors.transparent, // Remove divider color
                            ),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: ExpansionTile(
                                backgroundColor: Colors.transparent,
                                tilePadding: const EdgeInsets.all(0),
                                title: Text(
                                  dropdownValue == 'Date'
                                      ? DateFormat.yMMMMd()
                                          .format(groupKey as DateTime)
                                      : groupKey as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 13, 71, 161),
                                    fontFamily: 'serif',
                                  ),
                                ),
                                children: groupTasks.map((task) {
                                  return Dismissible(
                                    key: Key(task.getId),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Confirm"),
                                            content: Text(
                                                "Are you sure you wish to delete this task?"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text("DELETE")),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text("CANCEL"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onDismissed: (direction) {
                                      // Delete task from Firestore
                                      tasksRef.doc(task.getId).delete();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text("Task deleted")),
                                      );
                                    },
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      elevation: 0,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blue[300],
                                          child: const Icon(
                                            Icons.task_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          task.getTitle,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'serif-Regular',
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Start: ${DateFormat('hh:mm a').format(task.getStartTime)} - End: ${DateFormat('hh:mm a').format(task.getEndTime)}',
                                          style: const TextStyle(
                                            fontFamily: 'serif',
                                          ),
                                        ),
                                        trailing: PopupMenuButton<String>(
                                          onSelected: (String value) {
                                            switch (value) {
                                              case 'Prioritize':
                                                // _prioritizeTask(
                                                //     task.getId, task.priority);
                                                break;
                                              case 'Edit':
                                                _editTask(task);
                                                break;
                                              case 'Set Reminder':
                                                _setReminder(task);
                                                break;
                                              case 'Delete':
                                                tasksRef
                                                    .doc(task.getId)
                                                    .delete();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content:
                                                          Text("Task deleted")),
                                                );
                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                value: 'Prioritize',
                                                child: Text(task.priority
                                                    ? 'Unprioritize'
                                                    : 'Prioritize'),
                                              ),
                                              PopupMenuItem(
                                                value: 'Edit',
                                                child: Text('Edit'),
                                              ),
                                              PopupMenuItem(
                                                value: 'Set Reminder',
                                                child: Text('Set Reminder'),
                                              ),
                                              PopupMenuItem(
                                                value: 'Delete',
                                                child: Text('Delete'),
                                              ),
                                            ];
                                          },
                                        ),
                                        tileColor: Colors.transparent,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
