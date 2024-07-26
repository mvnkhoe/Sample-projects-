import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.title, required this.icon});

  final String title;
  final Icon icon;

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 114, 186, 245),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            widget.icon,
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Done',
                            style: TextStyle(
                                color: Color.fromARGB(255, 128, 240, 131),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'serif'),
                          ),
                          Text(
                            ' 0',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'serif'),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Text(
                            'Pending',
                            style: TextStyle(
                                fontFamily: 'serif',
                                color: Color.fromARGB(255, 148, 85, 85),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' 0',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'serif'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
