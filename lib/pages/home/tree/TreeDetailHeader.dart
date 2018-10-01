import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trees_co/pages/home/tree/ArcBannerImage.dart';
import 'package:trees_co/pages/home/tree/Poster.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/Routers.dart';

class TreeDetailHeader extends StatelessWidget {
  TreeDetailHeader(this.detail);

  final DocumentSnapshot detail;

  BuildContext context;
  _buildCategoryChips(TextTheme textTheme) {
    return <Widget>[
      Container(
        width: 85.0,
        child: new RaisedButton(
            onPressed: openAR,
            textColor: Colors.white,
            //minWidth: 50.0,
            color: Colors.green,
            child: Row(
              children: <Widget>[
                //Icon(Icons.camera),
                new Text("Preview"),
              ],
            )),
      ),
      new RaisedButton(
          onPressed: addToShoppingCard,
          textColor: Colors.white,
          color: Colors.blue,
          child: new Text("Buy now"))
    ];
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            detail[Fire.TREE_TITLE],
            style: textTheme.title,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Text(
            "\$" + detail[Fire.TREE_PRICE],
            style: textTheme.title.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).accentColor),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        ),
        new Padding(padding: const EdgeInsets.only(top: 70.0))
      ],
    );

    return new Stack(
      children: [
        new Padding(
          padding: const EdgeInsets.only(bottom: 240.0),
          child: new ArcBannerImage(detail[Fire.TREE_IMAGE]),
        ),
        new Positioned(
          bottom: 32.0,
          left: 8.0,
          right: 8.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Poster(
                detail[Fire.TREE_IMAGE],
                height: 190.0,
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  addToShoppingCard() {
    // When the button pressed add to the dataset

    Map<String, dynamic> values = {
      Fire.SHOPPING_CART_ITEM_PRICE: int.tryParse(detail[Fire.TREE_PRICE]),
      Fire.SHOPPING_CART_ITEM_IMAGE: detail[Fire.TREE_IMAGE],
      Fire.SHOPPING_CART_ITEM_QUANTITY: 0,
      Fire.SHOPPING_CART_ITEM_TITLE: detail[Fire.TREE_TITLE],
      Fire.SHOPPING_CART_TIME: new DateTime.now(),
    };


    Firestore.instance.collection(Fire.shoppingCart).add(values);

  }

  void openAR() {
    const platform = const MethodChannel(Routers.AR_KEY);

    Future<Null> _openAR() async {
      try {
        int result = await platform.invokeMethod('getAr');
      } on PlatformException catch (e) {
        _showDialog();
      }
    }

    _openAR();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("AR is not available"),
          content: new Text("AR is not available on your device"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
