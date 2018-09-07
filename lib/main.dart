import 'package:flutter/material.dart';
import 'package:trees_co/pages/SplashScreen.dart';
import 'package:trees_co/pages/HomeScreen.dart';
import 'package:trees_co/pages/IntroScreen.dart';


var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
};

void main() => runApp(new MaterialApp(
  theme: ThemeData(primaryColor: Colors.blue),
  home: SplashScreen(),
  routes: routes));


