import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Group_Layout/Group_Layout.dart';
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
    return MaterialApp(
      title: 'RoomShare',
      color: Colors.white,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Comparte.me'),
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
              builder: (context) => Asset_Calendar(),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Group_Layout(
                          groups[index].id, groups[index].name, iduser),
                    ));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
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
