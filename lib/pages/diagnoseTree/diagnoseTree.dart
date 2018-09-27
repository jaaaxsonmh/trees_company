import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import ''


class DiagnoseTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _diagnoseTree();
  }
}

class _diagnoseTree extends State<DiagnoseTree> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Diagnose Tree Health'),
            Icon(Icons.healing)
          ],
        )
      ),
      body: ListView(
        children: <Widget>[

           FlatButton(onPressed: () => MyNavigator.goToHome(context),
             color: Colors.green,
             padding: EdgeInsets.all(20.0),
             child: Icon(Icons.add_a_photo,
             color: Colors.white),
           ),

       /*  inputEmail,
         inputDetails,
         submitbutton,*/
        ],
      ),
    );
  }
}


/*padding: new EdgeInsets.all(20.0),
child: new Form(
key: this._formKey,
child: new ListView(
children: <Widget>[
new TextFormField(
keyboardType: TextInputType.emailAddress, // Use email input type for emails.
decoration: new InputDecoration(
hintText: 'you@example.com',
labelText: 'E-mail Address'
)
),
new TextFormField(
decoration: new InputDecoration(
hintText: 'Tell us what you think is wrong?',
labelText: 'Enter short details about the tree'
)
),
new Container(
child: new RaisedButton(
child: new Text(
'Send for Review',
style: new TextStyle(
color: Colors.white
),
),
// TODO: send data from each field and image to firebase
onPressed: () => null,
color: Colors.green,
),
margin: new EdgeInsets.only(
top: 20.0
),
),
new Container(
child:
new RaisedButton(
child: new Text(
'Send for Review',
style: new TextStyle(
color: Colors.white
),
),
// TODO: send data from each field and image to firebase
onPressed: () => null,
color: Colors.green,
),
)
],*/
