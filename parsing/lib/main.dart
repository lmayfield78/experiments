import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  String _body = "";
  String _title = "";

  print(_data[0]['title']);

  for (int i = 0; i < _data.length; i++) {
    print("Title: ${_data[i]['title']}");
    print("Body: ${_data[i]['body']}");
  }

  _body = _data[0]['body'];
  _title = _data[0]['title'];

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('JSON Parse'),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: _data.length,
              padding: EdgeInsets.all(14.5),
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.5),
                    ListTile(
                      title: Text(
                        "${_data[position]['title']}",
                        style: TextStyle(
                          fontSize: 17.9,
                        ),
                      ),
                      subtitle: Text(
                        "${_data[position]['body']}",
                        style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Text("${_data[position]['body'][0]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.4,
                          color: Colors.orangeAccent
                        ),),
                      ),

                      onTap:()=>showOnTapMessage(context, _data[position]['body']),

                    ),
                  ],
                );
              })),
    ),
  ));
}


void showOnTapMessage(BuildContext context, String message){

  var alert = AlertDialog(
    title: Text('My App'),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok'),
        onPressed: () {
          Navigator.pop(context);
        },)
    ],
    
  );

  // Many tutorials may teach users to use child. But it will be depricated.
  // So use this builder: property.
  showDialog(context: context, builder: (context)=> alert);


}

Future<List> getJson() async {
  String apiRul = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiRul);

  return json.decode(response.body);
}
