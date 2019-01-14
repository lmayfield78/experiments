import 'package:firebase_basic_template/model/board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


final FirebaseDatabase database = FirebaseDatabase.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Board',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Board> boardMessages = List();
  Board board;




  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

//  void _incrementCounter() {
//
//    database.reference().child("message").set(
//        {
//          "firstname" : "horse",
//          "Lastname" : "pow"
//    });
//    setState(() {
//
//      database.reference().child("message").once().then((DataSnapshot snapshot){
//        Map<dynamic, dynamic> list = snapshot.value;
//        print("Values from list : ${list.values}");
//      });
//
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("text"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),

    );
  }
}
