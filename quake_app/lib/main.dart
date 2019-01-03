import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Quake'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.5,),
                  ListTile(
                    title: Text('Title here!!',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic
                    ),),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text('E',
                      style: TextStyle(
                        fontSize: 16.4,
                        color: Colors.orangeAccent,

                      ),),

                    ),


                  ),
                ],

              );
            },
        ),
    ),
  )));
  }