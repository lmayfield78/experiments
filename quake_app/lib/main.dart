import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Map _data;
List _features;

void main() async {
  _data = await getQuakes();
  _features = _data['features'];

  print(_data['features']);

  runApp(MaterialApp(
    title: 'Quakes',
    home: Quakes(),
  ));
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quakes"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              // crafting rows and list views
              if (position.isOdd) return Divider();
              final index = position ~/ 2; // dividing by 2 and returning int.
              return ListTile(
                title: Text(
                  "Mag: ${_features[position]['properties']['mag']}",
                  style: TextStyle(
                      fontSize: 19.5,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("${_features[position]['properties']['place']}",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.5,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),),
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Text("${_features[position]['properties']['mag']}"),
                ),
              );
            }),
      ),
    );
  }
}

Future<Map> getQuakes() async {
  String apiQuake =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiQuake);
  return json.decode(response.body);
}
