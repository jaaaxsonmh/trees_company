import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trees_co/pages/home/tree/TreeDetailHeader.dart';
import 'package:trees_co/utils/Fire.dart';

class TreeDetailsPage extends StatelessWidget {
  TreeDetailsPage(this.detail);

  DocumentSnapshot detail;

  @override
  Widget build(BuildContext context) {
    var featureList = <Widget>[
      _getCard(context, Icon(Icons.map), "Origin: " + detail[Fire.TREE_WHERE_FROM]),
      _getCard(context, Icon(Icons.wb_sunny), "Sun requremnts: " + detail[Fire.TREE_SUN_REQ]),
      _getCard(context, Icon(Icons.assistant_photo), "Soil drainage: " + detail[Fire.TREE_SOIL_DRAINAGE]),
      _getCard(context, Icon(Icons.settings), "Maintenance required: " + detail[Fire.TREE_MAINTENANCE_REQ]),
      _getCard(context, Icon(Icons.more_vert), "Max height: " + detail[Fire.TREE_MAX_HEIGHT]),
      _getCard(context, Icon(Icons.aspect_ratio), "Growth rate: " + detail[Fire.TREE_GROWTH_RATE]),

    ];

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new TreeDetailHeader(detail),
            new Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                direction: Axis.horizontal,
                children: featureList,
              ),
            )
          ],
        ),
      ),
    );
  }

  _getCard(BuildContext context, Icon icon, String text) {
    return ListTile(
      leading: icon,
      title: Text(text),
    );
  }
}
