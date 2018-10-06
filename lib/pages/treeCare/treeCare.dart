import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class TreeCare extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TreeCareState();
  }
}

class _TreeCareState extends State<TreeCare> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(Fire.care).snapshots(),
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
        return buildPlantCare(snapshot); // scaffold
      },
    );
  }

  Scaffold buildPlantCare(AsyncSnapshot<QuerySnapshot> snapshot) {
    return new Scaffold(
          appBar: new AppBar(
              backgroundColor: Colors.green,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Plant Care Information'),
                  new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Icon(Icons.nature))
                ],
              )), // appBar
          body: new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, index) => _buildListItem(
                  context, snapshot.data.documents[index])));
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  print(document[Fire.CARE_SHORT]);
  return new Card(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
          key: new ValueKey(document.documentID),
          leading: new Icon(Icons.nature, size: 40.0, color: Colors.green),
          title: new Text(
            document[Fire.CARE_TYPE],
            style: new TextStyle(fontSize: 20.0),
          ),
          subtitle: new Text(document[Fire.CARE_SHORT]),
        ),
        new ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: new ButtonBar(
            children: <Widget>[
              new FlatButton(
                  child: new Text('Diagnose Plant Health',
                      style: new TextStyle(color: Colors.green)),
                  onPressed: () {
                    MyNavigator.goToDiagnoseTree(context);
                  }),
              new FlatButton(
                child: new Text('Full Details',
                    style: new TextStyle(color: Colors.green)),
                onPressed: () {
                  _showFullInfo(document, context);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void _showFullInfo(document, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(document[Fire.CARE_TYPE] + ' Care', style: TextStyle(color: Colors.green)),
        content: new Text(document[Fire.CARE_LONG]),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close",
            style: TextStyle(color: Colors.green)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


