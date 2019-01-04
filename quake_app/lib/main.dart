import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() async {

  List _data = await getJson();
  String _body = "";
  String _title = "";

  for (int i = 0; i < _data.length; i++) {
    print('Title: ${_data[i]['title']}');
    print('Body: ${_data[i]['body']}');
  }

  _title = _data[0]['title'];
  _body = _data[0]['body'];


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
              Divider(
                height: 5.5,
              ),
              ListTile(
                title: Text(
                  "${_data[position]['title']}",
                  style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
                subtitle: Text(
                  "${_data[position]['body']}",
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    'E',
                    style: TextStyle(
                      fontSize: 16.4,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),

                onTap: ()=>{},
              ),
            ],
          );
        },
      ),
    ),
  )));
}

Future<List> getJson() async {
  String apiQuake = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiQuake);

  return json.decode(response.body);
}

