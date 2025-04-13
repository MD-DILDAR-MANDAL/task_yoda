import 'package:flutter/material.dart';
import 'package:task_yoda/views/front_screen.dart';
import './models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //registering the adapter
  Hive.registerAdapter(TaskAdapter());
  //opening the box
  await Hive.openBox('myTaskBox');

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Yoda',
      theme: ThemeData(
        primarySwatch:Colors.green,
      ),
      home: const FrontScreen(),
    );
  }
}