import 'package:flutter/material.dart';

void main() => runApp(new TreesCo());

class TreesCo extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(
      primarySwatch: Colors.green
      )
    );
  }
}


class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(vsync: this,
    duration: new Duration(milliseconds: 1000)
    );
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.green,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/sprout.png"),
                height: _iconAnimation.value * 100,
                width: _iconAnimation.value * 100,
              ),
            ],
          )
        ],
      ),
    );
  }
}