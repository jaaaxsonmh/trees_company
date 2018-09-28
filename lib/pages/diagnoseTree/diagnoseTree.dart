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

  _onSubmit() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Container(
              child: new Image.asset("assets/sprout.png",
              width: 50.0, height: 50.0),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : <Widget>[
                Expanded(
                  child: Text(
                    'Thank you! \n A response is on its way \n While you wait check this out!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,

                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new Column( children: <Widget>[
                FlatButton(
                    child: new Text('Close', style: new TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {
                      //TODO: Send to detailed information of different tree types
                      Navigator.pop(context);
                    })
              ],
              ),
                  new Column( children: <Widget>[
                    FlatButton(
                        child: new Text('Home', style: new TextStyle(color: Colors.white)),
                        color: Colors.green,
                        onPressed: () {
                          //TODO: Send to detailed information of different tree types page
                          MyNavigator.goToHome(context);
                        })
                  ],)
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
                  padding: EdgeInsets.all(10.0),
                  child:
                  new Icon(Icons.healing)
              )
            ],
          )),
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: new TextFormField(
                keyboardType: TextInputType.emailAddress,
                // Use email input type for emails.
                decoration: new InputDecoration(
                    hintText: 'you@example.com', labelText: 'E-mail Address'))
          ),
          new Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child:new TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Tell us what you think is wrong?',
                    labelText: 'Enter short details about the tree'))
          ),
          new RaisedButton(
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
          Center(
            child: image == null
                ? new Padding(
              padding:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new Placeholder(
                  color: Colors.green,
                  fallbackHeight: 290.0,
                  fallbackWidth: 290.0),
            )
                : new Padding(
                padding:
                EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Image.file(image, width: 290.0, height: 290.0)),
          ),
            new Container(
              child: new RaisedButton(
                child: new Text(
                  'Send for Review',
                  style: new TextStyle(color: Colors.white),
                ),
                // TODO: send data from each field and image to firebase
                onPressed: () {
                  _onSubmit();
                  //TODO: add send to firebase
                },
                color: Colors.green,
              ),
            ),

        ],
      ),
    // this doesnt work since only 1 item, and it requires >= 2.
    /*  bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.check),
          title: new Text('Submit')
        )
      ]),*/
    );
  }
}
