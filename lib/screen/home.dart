import 'package:database_project/db/functions/dbfunctions.dart';
import 'package:database_project/screen/Screen_add.dart';
import 'package:database_project/screen/Screen_search.dart';
import 'package:database_project/screen/Screen_sudents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currenselectedindex = 0;
  final _pages = [
    Screenstudent(),
    Screenadd(),
    Screensearch(),
  ];
  @override
  Widget build(BuildContext context) {
    getAllstudents();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: new Text('Students Data'),
      ),
      body: _pages[currenselectedindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red[300],
        unselectedItemColor: Colors.amber[50],
        backgroundColor: Colors.black87,
        currentIndex: currenselectedindex,
        onTap: (newindex) {
          setState(() {
            currenselectedindex = newindex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
