import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Group_Layout/Group_Layout.dart';
import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comparte.me'),
        actions: <Widget>[
          //Widget para el desplegable add_group, Delete_group and profile
          Main_PopupMenu(),
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
            builder: (context) => User_Calendar(),
          ));
        },
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('group')
            .where('members', arrayContains: '2NddPpxy3J5zQFctupz5')
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
                    builder: (context) => Group_Layout(groups[index].id),
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
    );
  }
}
