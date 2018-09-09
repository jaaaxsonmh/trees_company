import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/widgets/introAnimation.dart';

class NewsFullInfo extends StatelessWidget {
  final DocumentSnapshot document;

  NewsFullInfo(this.document);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 10,
                    child: PageView(children: <Widget>[
                      //tree co welcome
                      IntroAnimation(
                        title: document[Fire.NEWS_TITLE],
                        content: document[Fire.NEWS_BODY],
                      )
                    ]),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],

              ),
    );
  }
}
