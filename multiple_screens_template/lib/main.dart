import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(title: "mutli-Screens", home: Home()));
}

/*
This is all of the logic
for the FIRST screen.

 */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _nameFieldController =
      TextEditingController(); // Text input var (in controller)

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return NextScreen(name: _nameFieldController.text);
    }));

    // covers the map data upon return
    if (results != null && results.containsKey('info')) {
      print(results['info']);
      _nameFieldController.text = results['info'].toString();
    } else {
      print('Nothing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: TextField(
              // 'Enter your name' input.
              controller: _nameFieldController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
          ),
          ListTile(
            // Confirm Button
            title: RaisedButton(
                child: Text('Send to Next Screen'),
                onPressed: () {
                  {
                    _goToNextScreen(context);
                  }
                }),
          )
        ],
      ),
    );
  }
}

/*
This is all of the logic
for the SECOND screen.
 */

class NextScreen extends StatefulWidget {
  // The widget

  final String name;

  const NextScreen({Key key, this.name}) : super(key: key); // Constructor

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  // The widget Next Screen state

  @override
  Widget build(BuildContext context) {
    var _backTextScreenController =
        TextEditingController(); // Text controller var

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Second Screen'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${widget.name}'), // Display the content from widget
            ),
            ListTile(
              title: TextField(
                controller: _backTextScreenController, // Textfield & Controller
              ),
            ),
            ListTile(
              title: FlatButton(
                  onPressed: () {
                    Navigator.pop(
                        // Takes text field content
                        context,
                        {'info': _backTextScreenController.text});
                  },
                  child: Text('Send Data Back')),
            )
          ],
        ),
      ),
    );
  }
}
