import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MoneyConverter.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/widgets/ArcBannerImage.dart';
import 'package:trees_co/widgets/Poster.dart';

class ToolsDetailHeader extends StatelessWidget {

  ToolsDetailHeader(this.document);

  final DocumentSnapshot document;

  BuildContext context;

  _buildCategoryChips(TextTheme textTheme) {
    return <Widget>[
      new RaisedButton(
          onPressed: pressedBuyButton,
          textColor: Colors.white,
          color: Colors.blue,
          child: new Text("Buy now"))
    ];
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var textTheme = Theme.of(context).textTheme;

    var price = MoneyConverter().convert(document[Fire.TOOLS_PRICE]);

    var movieInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            document[Fire.TOOLS_TITLE],
            style: textTheme.title,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Text(
            price,
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
          child: new ArcBannerImage(document[Fire.TOOLS_IMAGE]),
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
                document[Fire.TOOLS_IMAGE],
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


  pressedBuyButton() {
    // Show some UI -> get user QTY, etc

    addToShoppingCardDb();
  }

  addToShoppingCardDb() async {
    Firestore.instance
        .collection(Fire.shoppingCart)
        .where(Fire.SHOPPING_CART_ITEM_TITLE,
        isEqualTo: document[Fire.TOOLS_TITLE])
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents.isEmpty) {
        Map<String, dynamic> values = {
          Fire.SHOPPING_CART_ITEM_PRICE: document[Fire.TOOLS_PRICE],
          Fire.SHOPPING_CART_ITEM_IMAGE: document[Fire.TOOLS_IMAGE],
          Fire.SHOPPING_CART_ITEM_QUANTITY: 1,
          Fire.SHOPPING_CART_ITEM_TITLE: document[Fire.TOOLS_TITLE],
          Fire.SHOPPING_CART_TIME: new DateTime.now(),
          Fire.SHOPPING_CART_ITEM_TYPE: "Tool"
        };

        Firestore.instance.collection(Fire.shoppingCart).add(values);
      } else {
        querySnapshot.documents.forEach((value) {
          Map<String, dynamic> values = {
            Fire.SHOPPING_CART_ITEM_QUANTITY:
            value[Fire.SHOPPING_CART_ITEM_QUANTITY] + 1,
          };

          Firestore.instance
              .collection(Fire.shoppingCart)
              .document(value.documentID)
              .updateData(values);
        });
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(document[Fire.TOOLS_TITLE] + " added to shopping cart"),
        action: SnackBarAction(
            label: "View",
            onPressed: () {
              MyNavigator.goToCart(context);
            }),
      ));
    });
  }


}