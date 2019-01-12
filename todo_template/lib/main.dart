import 'package:flutter/material.dart';
import 'package:todo_template/ui/Home.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      home: Home(),
    );
  }
}
