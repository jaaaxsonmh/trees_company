import 'package:launch_review/launch_review.dart';
import 'package:flutter/material.dart';

class ReviewDialog extends StatelessWidget {
  BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return new AlertDialog(
      contentPadding: new EdgeInsets.all(0.0),
      content: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Colors.red,
            padding: new EdgeInsets.symmetric(vertical: 32.0),
            child: new Center(
              child:
              new Icon(Icons.rate_review, color: Colors.white, size: 50.0),
            ),
          ),
          new Container(
              margin:
              new EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: new Text('How about leaving some love?',
                  style: new TextStyle(
                      color: Colors.green,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold))),
          new Container(
              margin: new EdgeInsets.only(left: 16.0, right: 16.0),
              child: new Text(
                  'We value your opinions and experience with Plant A Tree\n Would you mind leaving a review?')),
          new Container(
            margin: new EdgeInsets.only(
                left: 16.0, top: 24.0, right: 16.0, bottom: 16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: new Text('No thanks'),
        ),
        new FlatButton(onPressed: () { LaunchReview.launch(androidAppId: 'androidId'); showRatedDialog(); },
            child: new Text('Lets rate this bitch'))
      ],
    );
  }

  List<Widget> children() {
    final icon = new Icon(Icons.star, color: Colors.yellow);
    return <Widget>[
              new FlatButton.icon(
                  onPressed: () => icon,
                  icon: new Icon(Icons.star), label: null),
              icon,
              icon,
              icon,
              icon,
              icon,
            ];
  }

  void showRatedDialog() {}
}
