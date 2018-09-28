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

  _buildCategoryChips(TextTheme textTheme) {
    return <Widget>[
      Container(
        width: 85.0,
        child: new RaisedButton(
            onPressed: launchARApplication,
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


  }

  launchARApplication() {
    const platform = const MethodChannel(Routers.AR_KEY);

    try {
      platform.invokeMethod('getAr');
    } on PlatformException catch (e) {
      // TODO: This is where iOS error message goes
    }

  }
}
