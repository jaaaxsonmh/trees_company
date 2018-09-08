import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 5000));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    Timer(
        Duration(seconds: 5),
            () => MyNavigator.goToIntro(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.lightGreen),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image(
                            image: new AssetImage("assets/sprout.png"),
                            height: _iconAnimation.value * 100,
                            width: _iconAnimation.value * 100,
                          ),
                          Text(
                            "Plant A Tree",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _iconAnimation.value * 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto"),
                          )
                        ]),
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                    )
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
