import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/pages/home/NewsFullInfo.dart';
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
}