import 'package:flutter/material.dart';

import '../searchpage/searchpage.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class topnavigation extends StatelessWidget {
  topnavigation({
    super.key,
  });

  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'TASONTIME',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    showSearch(context: context, delegate: CustomSearch());
                  },
                ),
                PopupMenuButton<SampleItem>(
                  initialValue: selectedItem,
                  iconColor: Colors.white,
                  onSelected: (SampleItem item) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemOne,
                      child: Row(
                        children: [
                          Icon(Icons.add_outlined,
                              color: Color.fromARGB(255, 114, 186, 240)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Task',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 186, 240)),
                          )
                        ],
                      ),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemTwo,
                      child: Row(
                        children: [
                          Icon(Icons.notifications_outlined,
                              color: Color.fromARGB(255, 114, 186, 240)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Reminder',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 186, 240)),
                          )
                        ],
                      ),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemThree,
                      child: Row(
                        children: [
                          Icon(Icons.person_outlined,
                              color: Color.fromARGB(255, 114, 186, 240)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 186, 240)),
                          )
                        ],
                      ),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemThree,
                      child: Row(
                        children: [
                          Icon(Icons.settings_outlined,
                              color: Color.fromARGB(255, 114, 186, 240)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 186, 240)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = ['Lesotho', 'Kenya', 'Nigeria', 'Egypt'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
