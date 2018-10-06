import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MoneyConverter.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CartState();
  }
}

class _CartState extends State<ShoppingCart> {
  Map<String, bool> values = {};

  int numberOfItemsInShoppingCart = 0;
  int totalPriceOfShoppingCart = 0;

  bool qtyControlsEnabled = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var price = MoneyConverter().convert(totalPriceOfShoppingCart);

    return new Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
            child: new Text(
              "Total: $price",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(
                onPressed: pressedBuy,
                textColor: Colors.white,
                //minWidth: 50.0,
                color: Colors.green,
                child: Row(
                  children: <Widget>[
                    //Icon(Icons.camera),
                    new Text('Buy ($numberOfItemsInShoppingCart)'),
                  ],
                )),
          ),
        ),
      ]),
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Shopping cart'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Icon(Icons.shopping_cart))
            ],
          )),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(Fire.shoppingCart)
            .orderBy(Fire.SHOPPING_CART_TIME)
            //.where(Fire.SHOPPING_CART_STATUS, isEqualTo: Fire.SHOPPING_CART_STATUS_CART)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return new Center(
              child: new SizedBox(
                height: 50.0,
                width: 50.0,
                child: new CircularProgressIndicator(
                  strokeWidth: 7.0,
                ),
              ),
            );
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]));
        },
      ),
    );
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (!values.containsKey(document.documentID)) {
      values[document.documentID] = false;
    }

    var price =
        MoneyConverter().convert(document[Fire.SHOPPING_CART_ITEM_PRICE]);
    var priceQTY = MoneyConverter().convert(
        document[Fire.SHOPPING_CART_ITEM_PRICE] *
            document[Fire.SHOPPING_CART_ITEM_QUANTITY]);

    var subInfo =
        "$price | QTY: ${document[Fire.SHOPPING_CART_ITEM_QUANTITY]} | Sub total: $priceQTY";

    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Dismissible(
              key: Key(document.documentID),
              direction: DismissDirection.endToStart,
              onDismissed: (dir) {
                Firestore.instance
                    .collection(Fire.shoppingCart)
                    .document(document.documentID)
                    .delete();

                _scaffoldKey.currentState.removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        document[Fire.SHOPPING_CART_ITEM_TITLE] + " removed")));
              },
              background: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete_sweep, color: Colors.white),
                ),
                alignment: Alignment.centerRight,
              ),
              child: new ListTile(
                key: new ValueKey(document.documentID),
                trailing: new Image.network(
                    document[Fire.SHOPPING_CART_ITEM_IMAGE],
                    width: 50.0,
                    height: 50.0),
                leading: new Checkbox(
                    value: values[document.documentID],
                    onChanged: (bool value) {
                      setState(() {
                        values[document.documentID] = value;

                        if (value) {
                          numberOfItemsInShoppingCart++;
                          totalPriceOfShoppingCart +=
                              document[Fire.SHOPPING_CART_ITEM_PRICE] *
                                  document[Fire.SHOPPING_CART_ITEM_QUANTITY];
                        } else {
                          numberOfItemsInShoppingCart--;
                          totalPriceOfShoppingCart -=
                              document[Fire.SHOPPING_CART_ITEM_PRICE] *
                                  document[Fire.SHOPPING_CART_ITEM_QUANTITY];
                        }
                      });
                    }),
                title: new Text(
                  document[Fire.SHOPPING_CART_ITEM_TITLE],
                ),
                subtitle: Column(
                  children: <Widget>[
                    new Text(subInfo),
                    new Divider(color: Colors.green),
                    Row(
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            if (qtyControlsEnabled) {
                              qtyControlsEnabled = false;

                              Map<String, dynamic> values = {
                                Fire.SHOPPING_CART_ITEM_QUANTITY:
                                    document[Fire.SHOPPING_CART_ITEM_QUANTITY] +
                                        1
                              };

                              Firestore.instance
                                  .collection(Fire.shoppingCart)
                                  .document(document.documentID)
                                  .updateData(values)
                                  .then((value) {
                                qtyControlsEnabled = true;
                              });

                              _scaffoldKey.currentState.removeCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      document[Fire.SHOPPING_CART_ITEM_TITLE] +
                                          " +1")));
                            }
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            if (qtyControlsEnabled) {
                              qtyControlsEnabled = false;

                              if (document[Fire.SHOPPING_CART_ITEM_QUANTITY] > 0) {
                                Map<String, dynamic> values = {
                                  Fire.SHOPPING_CART_ITEM_QUANTITY: document[
                                          Fire.SHOPPING_CART_ITEM_QUANTITY] - 1
                                };

                                Firestore.instance
                                    .collection(Fire.shoppingCart)
                                    .document(document.documentID)
                                    .updateData(values)
                                    .then((value) {
                                  qtyControlsEnabled = true;
                                });
                                ;

                                _scaffoldKey.currentState
                                    .removeCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(document[
                                            Fire.SHOPPING_CART_ITEM_TITLE] +
                                        " -1")));
                              }else{
                                qtyControlsEnabled = true;
                              }
                            }
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //onTap: () => _openNewsFullPage(context, document),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pressedBuy() {
    // Get the items and assign new db values

    void iterateMapEntry(key, value) {
      if (value) {
        // Get the current data
        Firestore.instance
            .collection(Fire.shoppingCart)
            .document(key)
            .get()
            .then((onValue) {
          Map<String, dynamic> newOrderData = {
            Fire.ORDER_ITEM_PRICE: onValue[Fire.SHOPPING_CART_ITEM_PRICE],
            Fire.ORDER_ITEM_IMAGE: onValue[Fire.SHOPPING_CART_ITEM_IMAGE],
            Fire.ORDER_ITEM_QUANTITY: onValue[Fire.SHOPPING_CART_ITEM_QUANTITY],
            Fire.ORDER_ITEM_TITLE: onValue[Fire.SHOPPING_CART_ITEM_TITLE],
            Fire.ORDER_TIME: new DateTime.now(),
            Fire.ORDER_ITEM_TYPE: Fire.SHOPPING_CART_ITEM_TYPE,
            Fire.ORDER_DETAILS: Fire.ORDER_DETAILS_PROCESSING
          };

          Firestore.instance
              .collection(Fire.shoppingCart)
              .document(key)
              .delete();
          Firestore.instance.collection(Fire.orders).add(newOrderData);
        });
      }
    }

    values.forEach(iterateMapEntry);

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Done! View your order status"),
      action: SnackBarAction(
          label: "View",
          onPressed: () {
            MyNavigator.goToMyOrders(context);
          }),
    ));
  }
}
