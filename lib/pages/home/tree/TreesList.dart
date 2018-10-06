import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MoneyConverter.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class TreesList extends StatelessWidget {

  final notfiltered = "";
  final filter = "Conifer";
  final filter2 = "Groundcover";
  final filter3 = "Trees";
  final filter4 = "Shrubs";


  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(Fire.trees).where(Fire.TREE_CATEGORY, isEqualTo: filter3).snapshots(),
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
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  var price = MoneyConverter().convert(document[Fire.TREE_PRICE]);
  return new Container(
    child: new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            key: new ValueKey(document.documentID),
            leading: new Image.network(document[Fire.TREE_IMAGE],
                width: 50.0, height: 50.0),
            title: new Text(document[Fire.TREE_TITLE],
                style: new TextStyle(fontSize: 20.0)),
            subtitle: new Text(document[Fire.TREE_CATEGORY]),
            trailing: new Text(price,
                style: new TextStyle(fontSize: 24.0, color: Colors.green)),
            onTap: () => _openNewsFullPage(context, document),
          ),
        ],
      ),
    ),
  );
}

_openNewsFullPage(BuildContext context, DocumentSnapshot document) {
  MyNavigator.goToTreeFullInfo(context, document);
}
