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
              plantType: "Shrubs",
              shortBrief: "Spring is a good time to prune, before the shrub leafs out",
              show: true),
          new CardLayout(
              plantIcon: Icons.fastfood,
              plantType: "Trees",
              shortBrief: "Keep power tools such as lawnmowers and string trimmers from striking the tree and damaging its bark",
              show: true),
          new CardLayout(
              plantIcon: Icons.nature_people,
              plantType: "Conifer",
              shortBrief: "It is best to fertilize in the early spring before the plants break dormancy.",
              show: true),
          new CardLayout(
              plantIcon: Icons.nature,
              plantType: "Groundcover Plant",
              shortBrief: "Routine watering, mulching, fertilizing, and grooming",
              show: true),
          new CardLayout(
              plantIcon: Icons.playlist_add_check,
              plantType: "Your plant not listed?",
              shortBrief:
                  "We will be sure to add it soon! \nUpload a photo for expert help.",
              show: false)
          //add a new card here and it will join the layout at bottom with same formats.
        ], // column
      ), // Container
    ); // scaffold
  }
}

class CardLayout extends StatelessWidget {
  CardLayout({this.plantIcon, this.plantType, this.shortBrief, this.show});

  final IconData plantIcon;
  final String shortBrief;
  final String plantType;
  final bool show;

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
                      }),
                  _buildChild()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildChild() {
    if(show) {
      return new FlatButton(
        child: new Text('Full Details',
            style: new TextStyle(color: Colors.green)),
        onPressed: () {
          //TODO: full details cards
        },
      );
    }
  }
}
