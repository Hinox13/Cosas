import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Profile/Profile.dart';
import 'package:projecte_visual/classes.dart';

class Add_Asset extends StatefulWidget {
  String idgroup;
  Add_Asset(this.idgroup);

  @override
  _Add_AssetState createState() => _Add_AssetState();
}

class _Add_AssetState extends State<Add_Asset> {
  TextEditingController _controllerName;
  @override
  void initState() {
    _controllerName = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    String idgroup = this.widget.idgroup;
    return Scaffold(
      appBar: AppBar(title: Text('Add Group')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerName,
              decoration: InputDecoration(labelText: 'Asset Name'),
              maxLength: 50,
              maxLengthEnforced: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    child: Text('Add'),
                    onPressed: () {
                      Firestore.instance
                          .collection('group')
                          .document(idgroup)
                          .collection('assets')
                          .add({'name': _controllerName.text});
                      Navigator.of(context).pop();
                    }),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
