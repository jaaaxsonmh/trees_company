import 'package:flutter/material.dart';
import 'package:trees_co/pages/SplashScreen.dart';
import 'package:trees_co/pages/cart/ShoppingCart.dart';
import 'package:trees_co/pages/home/HomeScreen.dart';
import 'package:trees_co/pages/IntroScreen.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/pages/Settings/settings.dart';
import 'package:trees_co/utils/Routers.dart';
import 'package:trees_co/pages/diagnoseTree/diagnoseTree.dart';
import 'package:trees_co/pages/deliveryDetails.dart';
import 'package:trees_co/pages/treeCare/treeCare.dart';

var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => HomeScreen(),
  Routers.intro: (BuildContext context) => IntroScreen(),
  Routers.login: (BuildContext context) => LoginPage(),
  Routers.orders: (BuildContext context) => ShoppingCart(),
  Routers.diagnoseTree: (BuildContext context) => DiagnoseTree(),
  Routers.settings: (BuildContext context) => Settings(),
  Routers.delivery: (BuildContext context) => DeliveryDetails(),
  Routers.treeCare: (BuildContext context) => TreeCare(),
  Routers.splash: (BuildContext context) => SplashScreen()
};

void main() => runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: LoginPage(),
    routes: routes));
