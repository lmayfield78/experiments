import 'package:flutter/material.dart';

class BmiHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BmiState();
  }
}

class BmiState extends State<BmiHome> {
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  double inches = 0.0;
  double result = 0.0;
  String _advice = '';
  String _finalResult = "";

  void calculate() {
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      inches = height * 12;
      double weight = double.parse(_weightController.text);

      if (_weightController.text.isNotEmpty ||
          weight > 0 && _heightController.text.isNotEmpty ||
          inches > 0 && _ageController.text.isNotEmpty ||
          age > 0) {
        result = weight / (inches * inches) * 703;
      }

      if (double.parse(result.toStringAsFixed(1)) < 18.5) {
        _advice = "Underweight";
      } else if (double.parse(result.toStringAsFixed(1)) >= 18.5 &&
          result < 25) {
        _advice = "Normal";
      } else if (double.parse(result.toStringAsFixed(1)) >= 25.0 &&
          result < 30.0) {
        _advice = "Overweight";
      } else if (double.parse(result.toStringAsFixed(1)) >= 30.0) {
        _advice = "Obese";
      } else {
        result = 0.0;
      }

      _finalResult = "Your BMI: ${result.toStringAsFixed(1)}";

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      /// APPBAR SECTION
      appBar: new AppBar(
        title: new Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),

      backgroundColor: Colors.grey,

      /// SCAFFOLD BG COLOR

      /// BODY
      body: new Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: EdgeInsets.all(19.0),
          children: <Widget>[
            /// BMI IMAGE
            new Image.asset(
              './images/bmilogo.png',
              height: 133,
              width: 200,
            ),

            /// INPUTS
            new Container(
              color: Colors.grey.shade200,
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  /// AGE INPUT
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Enter Your Age',
                      hintText: '99',
                      icon: Icon(Icons.person),
                    ),
                  ),

                  /// Height INPUT
                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Enter Your Height',
                      hintText: '5.8',
                      icon: Icon(Icons.face),
                    ),
                  ),

                  /// Weight INPUT
                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Enter Your Weight',
                      hintText: '215',
                      icon: Icon(Icons.person_outline),
                    ),
                  ),

                  new Padding(padding: EdgeInsets.all(10.0)),

                  new RaisedButton(
                    onPressed: calculate,
                    textColor: Colors.white,
                    color: Colors.purpleAccent,
                    child: const Text('Calculate'),
                  ),

                  new Padding(padding: EdgeInsets.all(10.0)),
                ],
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  '$_finalResult',
                  style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 33,
                  ),
                ),
                new Text(
                  '$_advice',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                    fontSize: 33,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
