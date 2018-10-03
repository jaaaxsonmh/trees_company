import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DiagnoseTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _diagnoseTree();
  }
}

class _diagnoseTree extends State<DiagnoseTree> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  File _image;
  String _name;
  String _details;
  int _total = 0;

  // for camera option
  _pickImageCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = img;
    setState(() {});
  }

  // for gallery option
  _pickImageGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  _onValid() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Container(
            child:
                new Image.asset("assets/sprout.png", width: 50.0, height: 50.0),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  'Click below to view the status of diagnostic',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new Column(
              children: <Widget>[
                FlatButton(
                    child: new Text('Close',
                        style: new TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            new Column(
              children: <Widget>[
                FlatButton(
                    child: new Text('View Status',
                        style: new TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {
                      MyNavigator.goToHome(context);
                    })
              ],
            )
          ],
        );
      },
    );
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
              new Padding(
                  padding: EdgeInsets.all(10.0), child: new Icon(Icons.healing))
            ],
          )),
      body: new ListView(
        padding: EdgeInsets.all(10.0),
         children: <Widget>[ new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                  // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: 'John Doe',
                      labelText: 'Name'),
                onSaved: (value) => _name = value,
                validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
              ),
              new TextFormField(
                      decoration: new InputDecoration(
                          hintText: 'Tell us what you think is wrong?',
                          labelText: 'Details'),
                    onSaved: (value) => _details = value,
                    validator: (value) => value.isEmpty ? 'Details can\'t be empty' : null,
                  ),
              new RaisedButton(
                onPressed: _pickImageGallery,
                color: Colors.green,
                child: Icon(Icons.add_a_photo, color: Colors.white),
              ),
              Center(
                child: _image == null
                    ? new Placeholder(
                            color: Colors.green,
                            fallbackHeight: 250.0,
                            fallbackWidth: 250.0)
                    : new Image.file(_image,
                            width: 270.0, height: 270.0),
              ),
              new Container(
                child: new RaisedButton(
                  child: new Text(
                    'Send for Review',
                    style: new TextStyle(color: Colors.white),
                  ),
                  // TODO: send data from each field and image to firebase
                  onPressed: () {
                    _saveDiagnosticDetails();
                  },
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }


  _saveDiagnosticDetails() async {

    final form = formKey.currentState;
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('diagnostics/diagnose$_total.jpg');
    final StorageUploadTask task = firebaseStorageRef.putFile(_image);

    if(form.validate()) {
      form.save();
      print('Valid details, $_name, $_details, $_total');
      _onValid();
      _totalImages();
    }
  }

  _totalImages() {
    _total++;
  }
}
