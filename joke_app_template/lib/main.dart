import 'package:flutter/material.dart';
import 'package:joke_app_template/ui/master_detail_creen.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MasterDetailScreen(),
    );
  }
}

