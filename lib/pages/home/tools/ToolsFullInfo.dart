import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';

class ToolInfo extends StatelessWidget {
  final DocumentSnapshot document;

  ToolInfo(this.document);

  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new RaisedButton(
          onPressed: pressedBuyButton,
          textColor: Colors.white,
          //minWidth: 50.0,
          color: Colors.green,
          child: Row(
            children: <Widget>[
              //Icon(Icons.camera),
              new Text('Buy'),
            ],
          )),
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Shopping cart'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Icon(Icons.shopping_basket))
            ],
          )),
      body: new Column(
        children: <Widget>[
          new Text(document[Fire.TOOLS_TITLE]),
          new Text("\$ " + document[Fire.TOOLS_PRICE].toString()),
          new Image.network(document[Fire.TOOLS_IMAGE],
              width: 50.0, height: 50.0)
        ]
      ),
    );
  }

  void pressedBuyButton() {
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
          Fire.SHOPPING_CART_ITEM_TYPE: "Tool",
        };

        Firestore.instance.collection(Fire.shoppingCart).add(values);
      } else {
        querySnapshot.documents.forEach((value) {


          Map<String, dynamic> values = {
            Fire.SHOPPING_CART_ITEM_QUANTITY: value[Fire.SHOPPING_CART_ITEM_QUANTITY] + 1,
          };

          Firestore.instance.collection(Fire.shoppingCart).document(value.documentID).updateData(values);

        });
      }
    });
  }

}
