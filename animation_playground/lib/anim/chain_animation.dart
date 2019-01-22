import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';


class ChainAnimation extends AnimatedWidget {
static final opacityTween = Tween<double>(begin: 0.1, end: 1.0);
static final sizeTween = Tween<double>(begin: 0.0, end: 175.0);


ChainAnimation({Key key, Animation<double> animation})
: super(key: key, listenable: animation);



@override
  Widget build(BuildContext context) {
  final Animation<double> animation = listenable;
    return Center(
      child: Opacity(opacity: opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: sizeTween.evaluate(animation),
        width: sizeTween.evaluate(animation),
        child: FlatButton(onPressed: null, child: Text("Button")),
      ),),
      
    );
  }
}