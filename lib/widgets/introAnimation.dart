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
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: create animiation controlller and curve in annimation
    // TODO: add listener
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = Tween(begin: -225.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut));
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    // dispose of animation.
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        animationDuration: Duration(milliseconds: 700),
        elevation: 1.5,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //title text
            new Transform(transform:
            new Matrix4.translationValues(_animation.value, 0.0, 0.0),
            child: new Text(
              widget.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: widget.color),
              ),
            ),
            new Transform(transform:
            new Matrix4.translationValues(_animation.value, 0.0, 0.0),
              child: new Text(
                widget.content,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,

                    color: widget.color),
              ),
            ),
            new Icon(
              widget.icon,
              size: 80.0,
              color: widget.color,
            )
          ],
        ),
      ),
    );
  }
}