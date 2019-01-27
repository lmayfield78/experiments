import 'package:flutter/material.dart';
import 'package:joke_app_template/model/joke.dart';

class JokeDetails extends StatelessWidget {

  JokeDetails({@required this.isInTableLayout,@required this.joke});

  final bool isInTableLayout;
  final Joke joke;


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(joke?.setup?? 'No Joke Selected',
          style: textTheme.headline,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(joke?.punchline??  'No Joke selected',
          style: textTheme.headline,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(joke?.punchline?? 'Please select a joke on the left',
          style: textTheme.subhead,),
        )
      ],
    );
    if(isInTableLayout){
      return Center(
        child: content,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(joke?.type?? 'No Jokes'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: content,
      ),
    );
  }
}
