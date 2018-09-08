import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: const EdgeInsets.only(top: 10.0),
            itemExtent: 55.0,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]));
      },
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return new ListTile(
    key: new ValueKey(document.documentID),
    title: new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: const Color(0x80000000)),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(document['title']),
          ),
          new Text(
            document['date'].toString(),
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
