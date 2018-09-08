import 'package:flutter/material.dart';
import 'package:trees_co/pages/SplashScreen.dart';
import 'package:trees_co/pages/HomeScreen.dart';
import 'package:trees_co/pages/IntroScreen.dart';
import 'package:trees_co/pages/LoginPage.dart';


var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/login": (BuildContext context) => LoginPage()
};

void main() => runApp(new MaterialApp(
  theme: ThemeData(primaryColor: Colors.blue),
  home: SplashScreen(),
  routes: routes));


