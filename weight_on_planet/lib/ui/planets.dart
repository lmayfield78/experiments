import 'package:flutter/material.dart';

class Planets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanetState();
  }
}

class PlanetState extends State<Planets> {
  final TextEditingController _weightController = new TextEditingController();
  int radioValue = 0;
  double _finalResult = 0.0;
  String _formattedText = "";

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue){
        case 0:
          _finalResult = calculateWeight(_weightController.text, 0.06);
          _formattedText = "Your weight on Pluto is ${_finalResult.toStringAsFixed(1)}";
          break;
        case 1:
          _finalResult = calculateWeight(_weightController.text, 0.38);
          _formattedText = "Your weight on Mars is ${_finalResult.toStringAsFixed(1)}";
          break;

        case 2: _finalResult = calculateWeight(_weightController.text, 0.91);
        _formattedText = "Your weight on Venus is ${_finalResult.toStringAsFixed(1)}";
        break;


      }


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black38,
        title: Text(
          "Weight On Planet",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          padding: EdgeInsets.all(2.5),
          children: <Widget>[
            new Image.asset(
              './images/planet.png',
              height: 133.0,
              width: 200.0,
            ),
            new Container(
                margin: EdgeInsets.all(3.0),
                alignment: Alignment.center,
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: 'Youre Weight on Earth',
                          hintText: 'In Pounds',
                          icon: Icon(Icons.person_outline)),
                    ),
                    new Padding(padding: EdgeInsets.all(5.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio<int>(
                            activeColor: Colors.brown,
                            value: 0,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged),
                        new Text(
                          'Pluto',
                          style: new TextStyle(
                            color: Colors.white30,
                          ),
                        ),
                        new Radio<int>(
                            activeColor: Colors.red,
                            value: 1,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged),
                        new Text(
                          'Mars',
                          style: new TextStyle(
                            color: Colors.white30,
                          ),
                        ),
                        new Radio<int>(
                            activeColor: Colors.orange,
                            value: 2,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged),
                        new Text(
                          'Venus',
                          style: new TextStyle(
                            color: Colors.white30,
                          ),
                        ),
                      ],
                    ),

                    new Padding(padding: new EdgeInsets.all(
                      15.6
                    )),


                    new Text(
                    _weightController.text.isEmpty ? "Please Enter Weight" : _formattedText + "lbs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.4,
                      fontWeight: FontWeight.w500,
                    ),)
                  ],
                )),
          ],
        ),
      ),
    );
  }

  double calculateWeight(String weight, double multiplier) {
    if (int.parse(weight).toString().isNotEmpty && int.parse(weight)>0){
      return int.parse(weight) * multiplier;

    }else {
      print("wrong!");

      return int.parse("180") * 0.38;

    }
    
    
  }
}
