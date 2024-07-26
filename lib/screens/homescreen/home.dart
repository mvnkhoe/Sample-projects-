import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'category.dart';
import 'floatingbutton.dart';
import 'topnavigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawerWidget(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 16, 114, 194),
            Color.fromARGB(255, 90, 167, 230),
            Color.fromARGB(255, 94, 174, 240)
          ])),
          child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white, // Change your drawer icon color here
            ),
            title: const Text(
              'Tasontime',
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              )
            ],
            backgroundColor:
                Colors.transparent, // Important to set this to transparent
            elevation: 0, // Remove shadow if needed
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(bottom: 0),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 114, 194),
                Color.fromARGB(255, 90, 167, 230),
                Color.fromARGB(255, 94, 174, 240)
              ],
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
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
              child: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            color: Color.fromARGB(255, 114, 186, 240),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Category(
                            title: 'Personal',
                            icon: Icon(
                              Icons.person_3_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Category(
                            title: 'Work',
                            icon: Icon(
                              Icons.work_history_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Category(
                            title: 'Shared',
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Category(
                            title: 'Others',
                            icon: Icon(
                              Icons.more_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ))
          ])),
      floatingActionButton: const FloatingButton(),
    );
  }

  Drawer _drawerWidget() {
    DateTime dateTime;
    return Drawer(
      child: Container(
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
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 35,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tau Lekhotla',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'tau@gmail.com',
                    style: TextStyle(color: Colors.white38),
                  ),
                ],
              ),
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.add_task_outlined,
                            color: Colors.blue),
                        trailing: const Icon(
                          color: Colors.lightBlue,
                          Icons.arrow_forward_ios,
                        ),
                        title: const Text('Add Task'),
                        onTap: () {
                          // Handle the tap
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.share_outlined,
                            color: Colors.blue),
                        title: const Text('Share Task'),
                        trailing: const Icon(
                          color: Colors.lightBlue,
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          // Handle the tap
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.share_outlined,
                            color: Colors.blue),
                        title: const Text('Share Task'),
                        trailing: const Icon(
                          color: Colors.lightBlue,
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          // Handle the tap
                        },
                      ),
                    ),
                    const Divider(
                      height: 80,
                      color: Colors.black38,
                      endIndent: BorderSide.strokeAlignOutside,
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.settings, color: Colors.blue),
                        title: const Text('Settings'),
                        onTap: () {
                          // Handle the tap
                        },
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.add)
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
