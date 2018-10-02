import 'package:flutter/material.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/utils/auth.dart';

class Root extends StatefulWidget {
  Root({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootState();
}

class _RootState extends State<Root> {

  @override
  Widget build(BuildContext context) {

    return new LoginPage(auth: widget.auth);
  }
}