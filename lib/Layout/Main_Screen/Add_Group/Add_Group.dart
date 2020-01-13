import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';

class Add_Group extends StatefulWidget {
  String userid;
  Add_Group(this.userid);

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
    String userid = this.widget.userid;
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
                    onPressed: () async {
                      Group newgroup = Group(_controllerName.text, userid, null,
                          [userid], _controllerdescription.text);
                      //Creem el document i el guardem per tal de tenir ja de firebase tota la info sobre aquest
                      DocumentReference ref = await Firestore.instance
                          .collection('group')
                          .add(newgroup.toFirestore());
                          //En el que acabavem de crear no hi havia la colleccio assets, per tant, en el grup que acabem d'afegir li posem la collection
                      Firestore.instance
                          .collection('group')
                          .document('${ref.documentID}')
                          .collection('assets')
                          .add({'name': 'The entire ${newgroup.name}'});
                          //Afegim el primer usuari que l'ha creat--> l'admin
                           
                          Firestore.instance.collection('users').document(userid).updateData({
      'group': FieldValue.arrayUnion(['${ref.documentID}'])
    });
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
