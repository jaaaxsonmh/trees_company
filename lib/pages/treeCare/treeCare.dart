//TODO: Everything
import 'package:flutter/material.dart';
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
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Plant Care Information'),
              new Padding(
                  padding: EdgeInsets.all(10.0), child: new Icon(Icons.help))
            ],
          )), // appBar
      body: new ListView(
        //TODO: get data from firebase
        children: <Widget>[
          new CardLayout(
              plantIcon: Icons.whatshot,
              plantType: "Palm Tree",
              shortBrief: "Grow slow\nWater every 2-3 weeks"),
          new CardLayout(
              plantIcon: Icons.fastfood,
              plantType: "Fruit Tree",
              shortBrief: "Fruit trees get nasty bugs!"),
          new CardLayout(
              plantIcon: Icons.nature_people,
              plantType: "Pine Tree",
              shortBrief: "Ever heard of a logging company?"),
          new CardLayout(
              plantIcon: Icons.nature,
              plantType: "Native New Zealand",
              shortBrief: "Best to upload an image, and get expert help!"),
          //add a new card here and it will join the layout at bottom with same formats.
        ], // column
      ), // Container
    ); // scaffold
  }
}

class CardLayout extends StatelessWidget {
  CardLayout({this.plantIcon, this.plantType, this.shortBrief});

  final IconData plantIcon;
  final String shortBrief;
  final String plantType;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Icon(plantIcon, size: 40.0, color: Colors.green),
              title: new Text(
                plantType,
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text(shortBrief),
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
                    }
                  ),
                  new FlatButton(
                    child: new Text('Full Details',
                        style: new TextStyle(color: Colors.green)),
                    onPressed: () {
                      //TODO: full details cards

                  },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
