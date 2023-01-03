import 'package:database_project/db/functions/dbfunctions.dart';
import 'package:database_project/model/data_model.dart';
import 'package:database_project/screen/Home/home.dart';
import 'package:database_project/screen/adding/adding_student/adding_student_bloc.dart';
import 'package:database_project/screen/edit/editing_student/editing_student_bloc.dart';
import 'package:database_project/screen/search/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(studentmodelAdapter().typeId)) {
    Hive.registerAdapter(studentmodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddingStudentBloc(),
        ),
        BlocProvider(create: (context) => EditingStudentBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage(),
      ),
    );
  }
}
