import 'package:database_template/models/user.dart';
import 'package:database_template/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

List _users;
void main() async {
  var db = new DatabaseHelper();

  // add user
   int saveduser = await db.saveUser(new User("Jon", "Doe"));
   print("user saved: $saveduser");

    // get all users
    _users = await db.getAllUsers();
    for(int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("User name: ${user.username}");
    }

  runApp(MaterialApp(
    title: 'db template',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),

    );
  }
}
