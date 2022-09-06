import 'dart:io';

import 'package:database_project/model/data_model.dart';
import 'package:flutter/material.dart';

class detailsScreen extends StatelessWidget {
  detailsScreen({Key? key, required this.student}) : super(key: key);
  studentmodel student;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(38.0),
          child: ListView(
            children: [
              CircleAvatar(
                backgroundImage: FileImage(File(student.image!)),
                radius: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Name : ${student.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              const SizedBox(
                height: 10,
              ),
              Center(child: Text("Age : ${student.age}")),
              const SizedBox(
                height: 5,
              ),
              Center(child: Text("Email :${student.email} ")),
              const SizedBox(
                height: 5,
              ),
              Center(child: Text("phone : ${student.phone}")),
            ],
          ),
        ),
      ),
    );
  }
}
