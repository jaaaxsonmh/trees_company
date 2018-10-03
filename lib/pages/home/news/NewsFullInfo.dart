import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:date_format/date_format.dart';

class NewsFullInfo extends StatelessWidget {
  final DocumentSnapshot document;

  NewsFullInfo(this.document);

  Widget build(BuildContext context) {
    var aNewsTime = document[Fire.NEWS_TIME];
    var newsTimeFormatted = formatDate(aNewsTime, [d, " ", M]);

    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildTreeCoLogo(),
          new Divider(color: Colors.green),
          buildCardView(newsTimeFormatted),
          buildBackButton(context),
        ],
      ),
    );
  }

  Expanded buildTreeCoLogo() {
    return Expanded(
            flex: 2,
            child: Container(
                child: new Image(
              image: new AssetImage("assets/sprout.png"),
              height: 150.0,
              width: 150.0,
            )));
  }

  Expanded buildCardView(String newsTimeFormatted) {
    return Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: Column(children: <Widget>[
                ListTile(
                    title: new Text(
                      document[Fire.NEWS_TITLE],
                      style:
                          new TextStyle(color: Colors.green, fontSize: 32.0),
                    ),
                    subtitle: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(newsTimeFormatted),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: new Container(
                              child: new Text(
                            document[Fire.NEWS_BODY],
                          )),
                        )
                      ],
                    )),
              ]),
            ),
          ),
        );
  }

  Expanded buildBackButton(BuildContext context) {
    return Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text('Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  onPressed: () => MyNavigator.goToHome(context),
                ),
              ],
            ));
  }
}
