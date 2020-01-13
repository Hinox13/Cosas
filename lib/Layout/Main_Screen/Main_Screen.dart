import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Group_Layout/Group_Layout.dart';
import 'package:projecte_visual/Layout/Main_Screen/User_Calendar/User_Calendar.dart';
import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/Asset_Calendar/Asset_Calendar.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

class MainScreen extends StatefulWidget {
  FirebaseUser user;
  MainScreen({this.user});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    String iduser = this.widget.user.uid;
    //Map<String,String> whos;
    return MaterialApp(
      title: 'RoomShare',
      color: Colors.white,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Groups'),
          actions: <Widget>[
            //Widget para el desplegable add_group, Delete_group and profile
            Main_PopupMenu(userid: iduser),
          ],
        ),
        //Codigo para la visualizacion del calendario acual
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => User_Calendar(iduser: iduser),
            ));
          },
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('group')
              .where('members', arrayContains: iduser)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;
            List<Group> groups = docaGrup_list(docs);

            return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //whos=who(groups[index].user_list);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Group_Layout(iduser: iduser, group: groups[index]),
                    ));
                  },
                  onLongPress: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.all(20),
                        title: Text('Delete ASSET'),
                        content:
                            Text("""Are you sure you want to DELETE THIS ASSET?

You will lose all the assets and events associated with this. """),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              setState(() {
/////////////ELIMINEM ELS EVENTS REFERITS ALS ASSETS DEL GROUP A ELIMINAR///////////////////////////////////////////////////////////

                               
                                Firestore.instance
                                    .collection('group')
                                    .document(groups[index].id)
                                    .collection('assets')
                                    .getDocuments()
                                    .then((documents) {
                                  documents.documents.forEach((doc) {
                                    Firestore.instance
                                        .collection('event')
                                        .where('assetid',
                                            isEqualTo: '${doc.documentID}')
                                        .getDocuments()
                                        .then((d) {
                                      d.documents.forEach((doc) {
                                      doc.reference.delete();
                                      });
                                    });
                                  });
                                });

///////////////////ELIMINEM LA COL·LECIÓ D'ASSETS DINS DEL DOCUMENT DE LA COL·LECIÓ GROUPS//////////////////
/////NOTA: si eliminem només el grup no s'acaba de borrar de firestore ja que la col·leció assets no s'elimina)////
                                Firestore.instance
                                    .collection('group')
                                    .document(groups[index].id)
                                    .collection('assets')
                                    .getDocuments()
                                    .then((docu) {
                                  docu.documents.forEach((doc) {
                                    doc.reference.delete();
                                  });
                                });

////////////////////ELIMINACIÓ DEL DOCUMENT GROUP DE LA COL·LECCIÓ GOUP//////////////////////////
                                Firestore.instance
                                    .collection('group')
                                    .document(groups[index].id)
                                    .delete();

//////////////////////ELIMINACIÓ DEL DATA GROUP DE L'ARRAY GROUPS DE CADA USUARI  //////////
                                ///                                       (falta fer)                             //////////

                                var ref = Firestore.instance
                                    .collection('users')
                                    .where('group',
                                        arrayContains: groups[index].id)
                                    .getDocuments()
                                    .then((documents) {
                                  documents.documents.forEach((doc) {
                                    Firestore.instance
                                        .collection('users')
                                        .document('${doc.documentID}')
                                        .updateData({
                                      'group': FieldValue.arrayRemove(
                                          [groups[index].id])
                                    });
                                  });
                                });

////////////////////////////////////////////////////////////////////////////////////////////
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.group,
                      size: 40,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(groups[index].name),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
