import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Profile/Profile.dart';
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
                    /* onPressed: () {
                  Group newgroup = Group(_controllerName.text,userid,null,[userid],_controllerdescription.text);
                  ///////OPCIO A funciona pero no crea la colleccio assets
                   Firestore.instance.collection('group').add(newgroup.toFirestore());
                    Navigator.of(context).pop();
                  },*/
                    ////////////OPCION B que crec que es mes correcta pero no acabo de trobar el comando

                    ////////////////////////////////////Aqui es crea el grup////////////////////////////////////////
                    onPressed: () async {
                      Group newgroup = Group(_controllerName.text, userid, null,
                          [userid], _controllerdescription.text);

                      DocumentReference ref = await Firestore.instance
                          .collection('group')
                          .add(newgroup.toFirestore());
                      Firestore.instance
                          .collection('group')
                          .document('${ref.documentID}')
                          .collection('assets')
                          .add({'name': 'The entire ${newgroup.name}'});
                      print('${ref.documentID}');
                      Navigator.of(context).pop();
                      /////////////////////////////////////////////aqui sabem la referencia del grup  pero no se
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
