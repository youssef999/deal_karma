import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:fire99/login.dart';
import 'package:fire99/saveImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'imgs.dart';

class AddPost extends StatefulWidget {
  String name, price, des, imgLocation, category;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //String imagepath;

  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController des = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController quant = TextEditingController();

  TextEditingController img = TextEditingController();
  File _image;
  String _url;

  sendData2() async {
    if (_formkey.currentState.validate()) {
      var storageImage = FirebaseStorage.instance.ref().child(_image.path);

      var task = storageImage.putFile(_image);

      _url = await (await task).ref.getDownloadURL();

      await Firestore.instance.collection('posts5').add({
        'name': name.text,
        'img': _url.toString,
        'des': des.text,
        'price': price.text
      });
    }
  }

  @override
  void dispose() {
    name.dispose();
    des.dispose();
    price.dispose();
    quant.dispose();
    super.dispose();
  }

  updatePost(String ID) {
    Firestore.instance.collection('posts5').document(ID).setData({
      'title': "Title Edited",
      'description': "Description Edited"
    }).then((value) {
      print('record updated successflly');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard / Add Post'),
          actions: <Widget>[
            RaisedButton(
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            _image == null ? null : FileImage(_image),
                        radius: 60,
                      ),
                      GestureDetector(
                        child: Icon(Icons.camera_alt),
                        onTap: pickImage,
                      )
                    ],
                  ),
                  /*  RaisedButton(
                        onPressed: () {
                          //  uploadImage(context);
                        },
                        child: Text("uplaod image"),
                      ),
                      */
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'product name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Fill Post name ';
                          }
                          // return 'Valid Name';
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: price,
                        decoration: InputDecoration(
                          hintText: 'price',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Fill Enter price ';
                          }
                          // return 'Valid Name';
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: quant,
                        decoration: InputDecoration(
                          hintText: 'quantatity',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Fill Enter quantity ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        controller: des,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Fill Description Input';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Add Post',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              var storageImage = FirebaseStorage.instance
                                  .ref()
                                  .child(_image.path);

                              var task = storageImage.putFile(_image);

                              _url = await (await task).ref.getDownloadURL();

                              Firestore.instance
                                  .collection('posts5')
                                  .document()
                                  .setData({
                                'name': name.text,
                                'img': _url.toString(),
                                'des': des.text,
                                'quant': quant.text,
                                'price': price.text,
                                'user': {
                                  'uid': currentUser.uid,
                                  'email': currentUser.email,
                                }
                              });
                            }
                          }),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'images',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HomeImg();
                            }),
                          );
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Delete Post',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            // Delete post

                            Firestore.instance
                                .collection('posts5')
                                .document('Wefs9XsNTeND7UXW7aXi')
                                .delete()
                                .then((onValue) {
                              print('Post Deleted Successfully');
                            });
                          }
                        },
                      )
                    ],
                  )
                ]))));
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //set state bt3ml update kol shwya

    setState(() {
      _image = image;
    });
  }

  Future uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://fire999-6d8b9.appspot.com');

      // StorageReference ref = storage.ref().child(_image.path);
      // StorageUploadTask storageUploadTask = ref.putFile(_image);
      //StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      //  String url = await taskSnapshot.ref.getDownloadURL();
      //  print('url $url');
      setState(() {
        //  _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
}
