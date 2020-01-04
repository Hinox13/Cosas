import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';
import 'package:qr_flutter/qr_flutter.dart';

String userid =
    'kFhr7ukMG6gqXg2Vyzpx'; //En principi un cop fet el loggin rebrem aquest camp

class Profile_Screen extends StatefulWidget {
  String userid;
  Profile_Screen(this.userid);
  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  TextEditingController _controllername, _controllerstatus;
  @override
  void initState() {
   _controllername= TextEditingController();
   _controllerstatus= TextEditingController();
    super.initState();
  }

  FutureOr _changeName(BuildContext context,User actualuser) {

    return showDialog(
       context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write your name'),
            content: TextField(
              controller: _controllername,
              decoration: InputDecoration(hintText: actualuser.name),
            ),
            actions: <Widget>[
              FlatButton(
                child:  Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
                FlatButton(
                child:  Text('SAVE'),
                onPressed: () async{
                  await Firestore.instance.collection('users').document(actualuser.id).updateData({'name': _controllername.text});
            
                  Navigator.of(context).pop();
                },)
            ],
          );
        });
  }
/*
  _changeStatus(BuildContext context)async {
    return showDialog();
  }*/

  @override
  Widget build(BuildContext context) {
    String userid= this.widget.userid;
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<User> user_list;
          user_list = docaUser_list(docs);
          User actual_user;
          for (var docu in docs) {
            if (docu.documentID == userid)
              actual_user =
                  User(docu.documentID, docu.data['name'], docu.data['status']);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //IMPLEMENTEM EL CODI QR AMB LES DADES DEL DOCUMENT ID
                QrImage(
                  data: actual_user.id,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 42),
                    Column(
                      children: <Widget>[
                        Text('User Name'),
                        SizedBox(height: 2),
                        Text(actual_user.name),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() => _changeName(context,actual_user));
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 42),
                    Column(
                      children: <Widget>[
                        Text('User State'),
                        SizedBox(width: 30),
                        Text(actual_user.status),
                        SizedBox(width: 10),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {/*
                        setState(() => _changeStatus(context));
                     */ },
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Number of groups'),
                    SizedBox(height: 2),
                    Text('REVISAR'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*

*/
