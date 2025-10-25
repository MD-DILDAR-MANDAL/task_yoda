import 'package:flutter/material.dart';
import 'package:task_yoda/views/front_screen.dart';
import './models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //registering the adapter
  Hive.registerAdapter(TaskAdapter());
  //opening the box
  await Hive.openBox<Task>('my_task_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FrontScreen());
  }
}
