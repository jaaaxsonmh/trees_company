import 'package:flutter/material.dart';
import 'package:trees_co/pages/SplashScreen.dart';
import 'package:trees_co/pages/home/HomeScreen.dart';
import 'package:trees_co/pages/IntroScreen.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/pages/home/NewsFullInfo.dart';
import 'package:trees_co/utils/Routers.dart';

var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => HomeScreen(),
  Routers.intro: (BuildContext context) => IntroScreen(),
  Routers.login: (BuildContext context) => LoginPage(),
};

void main() => runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: SplashScreen(),
    routes: routes));
