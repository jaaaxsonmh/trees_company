import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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