import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

void main() async {

  var data = await readData();

  if (data != null) {
    String message = await readData();
    print(message);
  }

  runApp(MaterialApp(
    title: 'Shared Pref',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
/*
This template will display the basic set up for setting up the logic
to find the local path, store the local path,
to write data to a file and to read that data.
 */

class _HomeState extends State<Home> {

  var _enterDataField = TextEditingController();
  String _savedData = "";



  @override
  void initState() {

    super.initState();

    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data').isNotEmpty && preferences.getString('data') != null){
        _savedData = preferences.get("data");
      }else{
        _savedData = "Empty. Please enter content";
      }
    });



  }

  _saveMessage(message) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("data", message); // key : value == login : password
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read / Write'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,

        child: Column(
          children: <Widget>[

            ListTile(
              title: TextField(
                controller: _enterDataField,
                decoration: InputDecoration(
                    labelText: 'Enter Text'
                ),
              ),
            ),

            ListTile(
              subtitle: FlatButton( // If you put this inside of the other ListTile, it will error. 
                  onPressed: () {
                    _saveMessage(
                        _enterDataField.text); // has to be converted to text.

                  },
                  child:
                  Column(
                    children: <Widget>[
                      Text('Save Data'),
                      Padding(padding: EdgeInsets.all(14.5)),
                      FutureBuilder(
                        future: readData(),
                          builder: (BuildContext context, AsyncSnapshot<String> data) {
                          if (data.hasData != null) {
                            return Container(
                              child: Text(
                                data.data.toString(),
                            style: TextStyle(
                            color: Colors.lightGreen
                              )),


                            );
                            }else{
                            Text("No data saved.");
                          }
                          }),
                      Text(_savedData)
                    ],
                  )),
            )


          ],
        ),


      ),
    );
  }
}
  // This method locates and returns the directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; // Home Directory
  }

  // This method will create the file in its directory
  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/data.txt'); // home/directory/data.txt
  }

  // This method writes the data to the local file.
  Future<File> writeData(String message) async {
    final file = await _localFile;

    //write to file
    return file.writeAsString('$message');
  }

  // This method will read the local file and store it in a variable
  Future<String> readData() async {
    try {
      final file = await _localFile;

      String data = await file.readAsString();

      return data;
    } catch (e) {
      return "Nothing saved!";
    }
  }

