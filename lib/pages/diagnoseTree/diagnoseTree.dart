import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiagnoseTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _diagnoseTree();
  }
}

class _diagnoseTree extends State<DiagnoseTree> {
  final _formKey = GlobalKey<FormState>();
  File image;


  // for camera option
  _pickImageCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    image = img;
    setState(() {});
  }

  // for gallery option
  _pickImageGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = img;
    setState(() {});
  }

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
          )),
      body: ListView(
        children: <Widget>[
          Center(
            child: image == null
                ? new Placeholder(color: Colors.green,
              fallbackHeight: 300.0, fallbackWidth: 300.0)
                : new Image.file(image, width: 300.0, height: 300.0),
          ),
          RaisedButton(
            onPressed: _pickImageGallery,
            color: Colors.green,
            /*(){
              new SimpleDialog(
              title: new Text('Camera'),
                children: <Widget>[
                  new FlatButton(onPressed: _pickImageCamera,
                      child: null),
                  new FlatButton(onPressed: _pickImageGallery,
                      child: null)
                ],
            );
            },*/
            child: Icon(Icons.add_a_photo, color: Colors.white),
          ),
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
