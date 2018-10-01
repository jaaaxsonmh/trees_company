import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/pages/home/news/NewsFullInfo.dart';
import 'package:trees_co/pages/home/tools/ToolsFullInfo.dart';
import 'package:trees_co/pages/home/tree/TreeDetailsPage.dart';
import 'package:trees_co/pages/home/tree/TreeInfo.dart';
import 'package:trees_co/utils/Routers.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, Routers.home);
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, Routers.intro);
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, Routers.login);
  }

  static void goToNewsFullInfo(BuildContext context, DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsFullInfo(document)),
    );
  }

  static void goToTreeFullInfo(BuildContext context, DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TreeDetailsPage(document)),
    );
  }

  static void goToToolFullInfo(BuildContext context, DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ToolInfo(document)),
    );
  }

  static void goToDiagnoseTree(BuildContext context) {
    Navigator.pushNamed(context, Routers.diagnoseTree);
  }

  static void goToSettings(BuildContext context) {
    Navigator.pushNamed(context, Routers.settings);
  }

  static void goToDelivery(BuildContext context) {
    Navigator.pushNamed(context, Routers.delivery);
  }

  static void goToTreeCare(BuildContext context) {
    Navigator.pushNamed(context, Routers.treeCare);
  }

  static void goToOrders(BuildContext context) {
    Navigator.pushNamed(context, Routers.orders);
  }

  static void goToSplash(BuildContext context) {
    Navigator.pushNamed(context, Routers.splash);
  }
}