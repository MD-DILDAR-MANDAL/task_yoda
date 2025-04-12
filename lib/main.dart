import 'package:flutter/material.dart';
import 'package:task_yoda/views/front_screen.dart';

void main() {
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