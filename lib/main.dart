import 'package:database_project/model/data_model.dart';
import 'package:database_project/screen/home.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
           primarySwatch: Colors.blue,
          ),
      home: Homepage(),
    );
  }
}
