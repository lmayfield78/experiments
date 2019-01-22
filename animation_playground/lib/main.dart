import 'package:animation_playground/anim/chain_animation.dart';
import 'package:flutter/material.dart';
import './anim/counter_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      title: 'Anim',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Horese are here'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with
SingleTickerProviderStateMixin{
AnimationController controller;
Animation<double> animation;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1800));
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn);
    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    //return ChainAnimation(animation: animation,);

//    return Scaffold(
//      body: ChainAnimation(animation: animation),
//    );
      return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center( child: CounterAnimator())
      // This trailing comma makes auto-formatting nicer for build methods.
    );


  }

}
