import 'package:flutter/material.dart';
import 'package:task_application/screens/taskPage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(),
      theme: ThemeData.dark(),
    );
  }
}