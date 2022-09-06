import 'dart:io';

import 'package:database_project/model/data_model.dart';
import 'package:database_project/screen/Screen_sudents.dart';
import 'package:database_project/screen/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Screensearch extends StatefulWidget {
  const Screensearch({Key? key}) : super(key: key);

  @override
  State<Screensearch> createState() => _searchstudentState();
}

class _searchstudentState extends State<Screensearch> {
  List<studentmodel> studentList =
      Hive.box<studentmodel>('student_db').values.toList();
  late List<studentmodel> displayStudent = List<studentmodel>.from(studentList);

  //get data => null;

  void updateList(String value) {
    setState(() {
      displayStudent = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            onChanged: (value) {
              updateList(value);
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              hintText: "Search here",
            ),
          ),
          // data = StudentList[index];
          Expanded(
            child: (displayStudent.isNotEmpty)
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      final data = displayStudent[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailsScreen(
                                      student: data,
                                      // student: data,
                                    )),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(File(displayStudent[index].image!)),
                        ),
                        title: Text(displayStudent[index].name),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: displayStudent.length)
                : Center(child: Text(" Not found")),
          )
        ]),
      ),
    );
  }
}
