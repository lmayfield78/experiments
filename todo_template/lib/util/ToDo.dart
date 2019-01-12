import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        tooltip: "Add Item",
          child: ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialogue),
    );
  }

  void _showFormDialogue() {
  }
}
