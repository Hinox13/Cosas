import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Profile_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where('name', isEqualTo: 'Oriol Hinojo')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                QrImage(
                  data: docs[0].documentID,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                Column(
                  children: <Widget>[
                    Text('User Name'),
                    SizedBox(height: 2),
                    Text(docs[0].data['name']),
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
                        Text(docs[0].data['status']),
                        SizedBox(width: 10),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
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
