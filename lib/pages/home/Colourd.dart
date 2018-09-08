import 'package:flutter/material.dart';


class Colourd extends StatelessWidget {
  final Color color;

  Colourd(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}