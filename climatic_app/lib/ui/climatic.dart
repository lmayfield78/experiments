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

  String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {

    Map results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ChangeCity();
    }));


    if (results != null && results.containsKey('enter')) {
      _cityEntered = results['enter'];
    }
  }

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
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _goToNextScreen(context);
              })
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
              "${_cityEntered == null ? util.defaultCity : _cityEntered}",
              style: cityStyle(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('./images/light_rain.png'),
          ),
          // Weather API container
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 380.0, 0.0, 0.0),
            child: updateTempWidget(_cityEntered),
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
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          // Here we will get Json and set up widgets,
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      content['main']['temp'].toString() + " F",
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),

                    ),
                    subtitle: ListTile(
                      title: Text(
                        "Humidity ${content['main']['humidity'].toString()}\n"
                            "Min: ${content['main']['temp_min'].toString()} F\n"
                            "Min: ${content['main']['temp_max'].toString()} F ",
                        style: extraData()

                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {

  final _cityFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Change City'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('./images/white_snow.png',
                width: 490.0, height: 1200.0, fit: BoxFit.fill),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City'
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                    onPressed: (){
                      Navigator.pop(context, {
                        'enter': _cityFieldController.text
                      });
                    },
                    color: Colors.lightBlueAccent,
                    textColor: Colors.black,
                    child: Text('Get Weather'),

                ),
              )
            ],
          )
        ],
      ),
    );
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

TextStyle extraData() {
  return TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.normal,
    fontSize: 17.0,
  );
}