import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CartState();
  }
}

class _CartState  extends State<ShoppingCart> {

  Map<String, bool> values = {
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: new Text("total: \$: todo"),
            ),
            Container(
              child: new RaisedButton(
                  onPressed: pressedBuyButtonn,
                  textColor: Colors.white,
                  //minWidth: 50.0,
                  color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      //Icon(Icons.camera),
                      new Text("Buy"),
                    ],
                  )) ,
            ),
          ]

      ),
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Shopping cart'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                  new Icon(Icons.shopping_basket)
              )
            ],
          )),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(Fire.shoppingCart).orderBy(Fire.SHOPPING_CART_TIME).snapshots(),
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
              itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]));
        },
      ),
    );
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {

    if (!values.containsKey(document.documentID)){
      values[document.documentID] = false;
    }


    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              key: new ValueKey(document.documentID),
              leading: new Checkbox(value: values[document.documentID], onChanged: (bool value) {
                setState(() {
                  values[document.documentID] = value;
                });
              }),
              title: new Text(
                "Item",
              ),
              subtitle: new Text("Item"),
              //onTap: () => _openNewsFullPage(context, document),
            ),
          ],
        ),
      ),
    );

  }

  void pressedBuyButtonn() {

  }

}
