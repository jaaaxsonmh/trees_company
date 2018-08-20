import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new TreesCo());

class TreesCo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new SplashScreen(),
        theme: new ThemeData(primarySwatch: Colors.red));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class SplashScreen extends StatefulWidget {
  @override
  State createState() => new SplashScreenState();
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
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.blue),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/heart.png"),
              height: 128.0,
              width: 128.0
            ),
            Text(
              "ur all gay",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,),
            )
          ],
        ),
      ],
    ));
  }
}
