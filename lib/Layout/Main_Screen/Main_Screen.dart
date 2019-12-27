import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';

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
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = docs[index].data;
              return InkWell(
                onTap: (){},
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(data['name']),
                  ),
                ),
              );
            },
          );
          /*
          2NddPpxy3J5zQFctupz5
          */
        },
      ),
    );
  }
}
