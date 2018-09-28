import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    Timer(Duration(milliseconds: 5000), () => openNextPage());
  }

  openNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isIntro = false;
    try{
      isIntro  = prefs.getBool("isIntro") ?? false;
    }catch (e){
    }

    if (isIntro) {
      MyNavigator.goToHome(context);
    } else {
      MyNavigator.goToIntro(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(color: Colors.green),
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
                      )
                    ]),
              )),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Plant A Tree",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:  26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
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
