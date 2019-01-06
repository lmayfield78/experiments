import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Climatic extends StatefulWidget {
  @override
  _ClimaticState createState() => _ClimaticState();
}

class _ClimaticState extends State<Climatic> {
  void apiTest() async {
    Map data = await getWeather(util.appId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Climatic'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: apiTest)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              './images/umbrella.png',
              width: 490.0,
              height: 1200,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.0, 30.0, 0.0),
            child: Text(
              "Austin",
              style: cityStyle(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('./images/light_rain.png'),
          ),
          // Weather API container
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 350.0, 0.0, 0.0),
            child: updateTempWidget('Austin'),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    /*
    This function will contact the weather api.
    - String api url
    - response from the url
    - decode the response

    REQUIRES:
    import '../util/utils.dart' as util;
    import 'dart:async';
    import 'package:http/http.dart' as http;
    import 'dart:convert';

     */

    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${util.appId}&units=imperial";

    http.Response response = await http.get(apiUrl);

    return jsonDecode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(util.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          // Here we will get Json and set up widgets,
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(content['main']['temp'].toString(),
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,

                    ),),

                  )
                ],
              ),
            );
          }else {
            return Container();
          }
        });
  }
}

TextStyle cityStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 44.0,
  );
}

TextStyle tempStyle() {
  return TextStyle(
    color: Colors.blueAccent,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 50.0,
  );
}
