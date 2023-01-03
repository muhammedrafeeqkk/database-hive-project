// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:database_project/db/functions/dbfunctions.dart';
import 'package:database_project/model/data_model.dart';
import 'package:database_project/screen/details/screen_details.dart';
import 'package:database_project/screen/edit/screen_edit.dart';
import 'package:flutter/material.dart';

class Screenstudent extends StatelessWidget {
  const Screenstudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: StudentListnotifier,
      builder:
          (BuildContext ctx, List<studentmodel> StudentList, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StudentList.isEmpty
              ? Center(
                  child: Text(
                  'No List found',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ))
              : ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = StudentList[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(255, 58, 60, 62),
                                Color.fromARGB(255, 144, 137, 137)
                              ])),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailsScreen(
                                      student: data,
                                    )),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(data.image!)),
                        ),
                        title: Text(data.name),
                        // subtitle: Text(data.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Editscreen(
                                              student: data,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      'Alert !',
                                      // style: TextStyle(color: Colors.red),
                                    ),
                                    // backgroundColor: Colors.red,
                                    content:
                                        const Text('Do you Want to Delete ?'),

                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deletestudent(data.key);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );

                                // deletestudent(data.key);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: StudentList.length),
        );
      },
    );
  }
}
