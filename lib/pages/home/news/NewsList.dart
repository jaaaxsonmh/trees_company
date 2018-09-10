import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(Fire.news).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Center(
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
            padding: const EdgeInsets.all(10.0),
            itemExtent: 55.0,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]));
      },
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return new ListTile(
    dense: true,
    key: new ValueKey(document.documentID),
    title: new Container(
      decoration: new BoxDecoration(
        border: new BorderDirectional(bottom: BorderSide(color: Colors.green, width: 1.0,
            style: BorderStyle.solid)),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(document[Fire.NEWS_TITLE]),
          ),
          new Text(
            document[Fire.NEWS_DATE].toString(),
          ),
        ],
      ),
    ),
    onTap: () => _openNewsFullPage(context, document),
  );
}

_openNewsFullPage(BuildContext context, DocumentSnapshot document) {
  MyNavigator.goToNewsFullInfo(context, document);
}
