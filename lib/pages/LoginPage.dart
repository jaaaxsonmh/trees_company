import 'package:flutter/material.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
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