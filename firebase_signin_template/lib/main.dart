import 'package:firebase_basic_template/model/board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageUrl;
  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    board = Board("", "");
    databaseReference = database.reference().child("community_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Board"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                    child: Text("Google Sign In"),
                    onPressed: () => _googleSignin(),
                    color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () => _signinWithEmail(),
                  child: Text("Sign in with Email"),
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () => _createUser(),
                  child: Text("Create Account"),
                  color: Colors.lightBlueAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () => _logout(),
                  child: Text("Sign Out"),
                  color: Colors.pinkAccent,
                ),
              ),
              Image.network(_imageUrl == null || _imageUrl.isEmpty
                  ? "http://pluspng.com/img-png/PNG_transparency_demonstration_1.png"
                      ""
                  : _imageUrl)
            ],
          ),
        ));
  }

  Future<FirebaseUser> _googleSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("User is: ${user.photoUrl}");
    setState(() {
      _imageUrl = user.photoUrl;
    });
    return user;
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      // Save form data to database
      databaseReference.push().set(board.toJson());
    }
  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] =
          Board.fromSnapshot(event.snapshot);
    });
  }

  Future _createUser() async {
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
            email: "horseface@gmail.com", password: "test1234")
        .then((user) {
      print("User Created: ${user.displayName}");
      print("Email: ${user.email}");
    });
  }

  _logout() {
    setState(() {
      _googleSignIn.signOut();
      _imageUrl = null;
    });
  }

  _signinWithEmail() {
    _auth
        .signInWithEmailAndPassword(
            email: "horseface@gmail.com", password: "test1234")
        .catchError((error) {
      print("Login error ${error.toString()}");
    }).then((user) {
      print("User signed in: ${user.email}");
    });
  }
}
