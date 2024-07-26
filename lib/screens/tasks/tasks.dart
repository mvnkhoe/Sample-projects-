import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ordernow/crude_widgets/add_task.dart';
import 'package:ordernow/models/task.dart';
import 'package:ordernow/notifications/notifications.dart';
import 'nav.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  final List<Task> _tasks = [
    Task(
      "Read",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 21, 00),
    ),
    Task(
      "Read",
      DateTime(2024, 05, 27, 20, 30),
      DateTime(2024, 05, 27, 21, 00),
    ),
    Task(
      "Read",
      DateTime(2024, 05, 29, 20, 30),
      DateTime(2024, 05, 29, 21, 00),
    ),
    Task(
      "Cooking",
      DateTime(2024, 05, 27, 20, 30),
      DateTime(2024, 05, 27, 21, 00),
    ),
    Task(
      "Training",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 21, 30),
    ),
    Task(
      "Designing App",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 20, 00),
    ),
    Task(
      "Coding App",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 20, 00),
    ),
    Task(
      "Read",
      DateTime(2024, 05, 27, 20, 30),
      DateTime(2024, 05, 27, 21, 00),
    ),
    Task(
      "Cooking",
      DateTime(2024, 05, 27, 20, 30),
      DateTime(2024, 05, 27, 21, 00),
    ),
    Task(
      "Training",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 21, 30),
    ),
    Task(
      "Designing App",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 20, 00),
    ),
    Task(
      "Coding App",
      DateTime(2024, 05, 28, 20, 30),
      DateTime(2024, 05, 28, 20, 00),
    )
  ];
  Map<DateTime, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final Map<DateTime, List<Task>> groupedTasks = {};

    for (var task in tasks) {
      final DateTime dateKey = task.getStartTime;

      if (!groupedTasks.containsKey(dateKey)) {
        groupedTasks[dateKey] = [];
      }

      groupedTasks[dateKey]!.add(task);
    }

    return groupedTasks;
  }

  DateTime dateTime = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Task>> groupedTasks = _groupTasksByDate(_tasks);
    final List<DateTime> dateKeys = groupedTasks.keys.toList();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 0),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 16, 114, 194),
          Color.fromARGB(255, 90, 167, 230),
          Color.fromARGB(255, 94, 174, 240)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Nav(),
            const SizedBox(
              height: 20,
            ),
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
                          fontFamily: 'serif'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('EEE, M/d/y').format(dateTime).toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'serif'),
                    )
                  ],
                ),
                Divider(),
                Divider(),
                Divider(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: AddTask(
                            scaffoldKey: _scaffoldKey,
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: ListView.builder(
                    itemCount: groupedTasks.length,
                    itemBuilder: (context, index) {
                      DateTime dateKey = dateKeys[index];
                      List<Task> items = groupedTasks[dateKey]!;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8.0,
                              spreadRadius: 4.0,
                              offset: Offset(4.0, 4.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue[100]!,
                                    Colors.blue[200]!
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Text(
                                DateFormat.yMMMMd()
                                    .format(DateTime.parse('$dateKey')),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.blue[900],
                                  fontFamily:
                                      'serif', // Apply Merriweather font
                                ),
                              ),
                            ),
                            Column(
                              children: items.map(
                                (item) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 12.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 3.0,
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue[300],
                                        child: const Icon(Icons.task_outlined,
                                            color: Colors.white),
                                      ),
                                      title: Text(
                                        item.getTitle,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                              'serif-Regular', // Apply Merriweather font
                                        ),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          color: Colors.blue[300]),
                                      tileColor: Colors.blue[50],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTasks(String title, DateTime start, DateTime end) {
    _tasks.add(Task(title, start, end));
  }
}
