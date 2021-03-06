import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:date_format/date_format.dart';
import 'package:trees_co/utils/MoneyConverter.dart';

class MyOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyOrders();
  }
}

class _MyOrders extends State<MyOrders> {
  Map<String, bool> values = {};

  int numberOfItemsInShoppingCart = 0;
  int totalPriceOfShoppingCart = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('My orders'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Icon(Icons.assignment))
            ],
          )),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(Fire.orders)
            .orderBy(Fire.SHOPPING_CART_TIME, descending: true)
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

    var orderRawTime = document[Fire.ORDER_TIME];
    var orderTimeFormatted = formatDate(
        orderRawTime, [yyyy, '-', m, '-', d, ' ', hh, '-', mm, '-', ss]);

    // Get the order status from db
    var orderStatus = document[Fire.ORDER_DETAILS];

    var status = "";
    if (orderStatus == null) {
      status = "Awating";
    } else if (orderStatus == Fire.ORDER_DETAILS_PROCESSING) {
      status = "We are processing your order.";
    } else if (orderStatus == Fire.ORDER_DETAILS_DISPATCHED) {
      status = "Your order has been dispatched.";
    } else if (orderStatus == Fire.ORDER_DETAILS_OUT_FOR_DELIVERY) {
      status = "Your order is with a courier now.";
    } else if (orderStatus == Fire.ORDER_DETAILS_OUT_FOR_SUCCESS) {
      status = "Your order is delivered. Hope you enjoing it!";
    } else if (orderStatus == Fire.ORDER_DETAILS_AVAILABLE_FOR_PICKUP) {
      status = "Your order is avalibe to pickup.";
    }

    var price = MoneyConverter().convert(document[Fire.SHOPPING_CART_ITEM_PRICE]);
    var priceQTY = MoneyConverter().convert(document[Fire.SHOPPING_CART_ITEM_PRICE] * document[Fire.SHOPPING_CART_ITEM_QUANTITY]);

    var orderInfo =
        "$price | QTY: ${document[Fire.SHOPPING_CART_ITEM_QUANTITY]} | Sub total: $priceQTY";

    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              key: new ValueKey(document.documentID),
              leading: new Image.network(
                  document[Fire.SHOPPING_CART_ITEM_IMAGE],
                  width: 50.0,
                  height: 50.0),
              title: new Text(
                document[Fire.SHOPPING_CART_ITEM_TITLE],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Order time: " + orderTimeFormatted),
                  new Divider(color: Colors.green),
                  new Text(orderInfo),
                  new Divider(color: Colors.green),
                  new Text(
                    status,
                    style: TextStyle(fontSize: 17.0, color: Colors.green),
                  )
                ],
              ),
              //onTap: () => _openNewsFullPage(context, document),
            ),
          ],
        ),
      ),
    );
  }
}
