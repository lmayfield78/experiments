import 'package:flutter/material.dart';
import 'package:todo_template/util/ToDo.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: ToDoScreen(),
    );
  }
}
