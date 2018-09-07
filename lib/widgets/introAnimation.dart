import 'package:flutter/material.dart';

class introAnimation extends StatefulWidget {
  final title;
  final content;
  final icon;
  final color;

  introAnimation(
  {
    this.title,
    this.content,
    this.icon,
    this.color = Colors.green
}
      );

  @override
  introAnimationState createState() {
    return introAnimationState();
  }
}

class introAnimationState extends State<introAnimation>
  with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    // TODO: create animiation controlller and curve in annimation
    // TODO: add listener
    super.initState();
  }

  @override
  void dispose() {
    // TODO: dispose of animation.
  }

  @override
  Widget build(BuildContext context) {
    // TODO: build container for display with fonts
    // TODO: set animations to the texts
    // TODO: define icon size
    return new Container(

    );
  }
}