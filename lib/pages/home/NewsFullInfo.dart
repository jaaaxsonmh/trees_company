import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NewsFullInfo extends StatelessWidget {
  final DocumentSnapshot document;

  NewsFullInfo(this.document);

  @override
  Widget build(BuildContext context) {
    return new Text(
      document['body'].toString()
    );
  }
}