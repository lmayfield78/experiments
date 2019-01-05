import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

// Date format: https://docs.flutter.io/flutter/intl/DateFormat-class.html

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
              var format = DateFormat.yMMMMd("en_US").add_jm();
              //var dateString = format.format(date);

              var date = format.format(DateTime.fromMillisecondsSinceEpoch(
                  _features[position]['properties']['time'],
                  isUtc: true));

              return ListTile(
                title: Text(
                  "At: $date",
                  style: TextStyle(
                      fontSize: 19.5,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "${_features[position]['properties']['place']}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.5,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Text(
                    "${_features[position]['properties']['mag']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.5,
                      color: Colors.red,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                onTap: () {
                  _showAlertMessage(context, "Location: ${_features[index]['properties']['title']}");
                },
              );
            }),
      ),
    );
  }

  void _showAlertMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text('Quakes'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.pop(context);},
            child: Text('OK'))
      ],

    );
    showDialog(context: context, builder: (context)=>alert);
  }
}

Future<Map> getQuakes() async {
  String apiQuake =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiQuake);
  return json.decode(response.body);
}
