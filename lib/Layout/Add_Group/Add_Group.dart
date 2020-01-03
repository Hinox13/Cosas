import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Profile/Profile.dart';
import 'package:projecte_visual/classes.dart';

class Add_Group extends StatefulWidget {
  Add_Group(iduser);

  @override
  _Add_GroupState createState() => _Add_GroupState();
}

class _Add_GroupState extends State<Add_Group> {
  TextEditingController _controllerName;
  TextEditingController _controllerdescription;
  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerdescription = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Group')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerName,
              decoration: InputDecoration(labelText: 'Group Name'),
              maxLength: 50,
              maxLengthEnforced: false,
            ),
            TextField(
              controller: _controllerdescription,
              decoration: InputDecoration(labelText: 'Group Description'),
              maxLength: 150,
              maxLengthEnforced: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                  Group newgroup = Group(_controllerName.text,userid,null,[userid],_controllerdescription.text);
                   Firestore.instance.collection('group').add(newgroup.toFirestore());
                    Navigator.of(context).pop();
                  },
                ),
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
