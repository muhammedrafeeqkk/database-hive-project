import 'package:database_project/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<studentmodel>> StudentListnotifier = ValueNotifier([]);

Future<void> addStudent(studentmodel value) async {
  // StudentListnotifier.value.add(value);

  final studentDB = await Hive.openBox<studentmodel>('student_db');

  await studentDB.add(value);
  StudentListnotifier.value.add(value);
  StudentListnotifier.notifyListeners();

  // print(
  //   value.toString(),
  // );
}

Future<void> getAllstudents() async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  StudentListnotifier.value.clear();
  StudentListnotifier.value.addAll(studentDB.values);
  StudentListnotifier.notifyListeners();
}

Future<void> deletestudent(int id) async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  await studentDB.delete(id);
  getAllstudents();
}

Future<void> editstudent(int id, studentmodel value) async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  await studentDB.put(id, value);
  getAllstudents();
}
