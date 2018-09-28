import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class TreesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(Fire.trees).snapshots(),
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
  return new Container(
    child: new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            key: new ValueKey(document.documentID),
            leading: new Image.network(document[Fire.TREE_IMAGE], width: 50.0, height: 50.0),
            title: new Text(
              document[Fire.TREE_TITLE],
            ),

            /*new Container(
      padding: const EdgeInsets.all(10.0),
      height: 100.0,
      width: 100.0,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(document[Fire.TREE_TITLE]),
          ),
          new Image.network(document[Fire.TREE_IMAGE], scale: ,),
        ],
      ),
    ), */
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
