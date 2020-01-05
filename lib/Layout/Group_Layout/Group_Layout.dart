import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Group_Layout/Widgets/Main_popupMenu2.dart';
import 'package:projecte_visual/Layout/Asset_Calendar/Asset_Calendar.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

class Group_Layout extends StatefulWidget {
  final String idgroup, namegroup, iduser;
  Group_Layout(this.idgroup,this.namegroup, this.iduser);
  @override
  _Group_LayoutState createState() => _Group_LayoutState();
}

class _Group_LayoutState extends State<Group_Layout> {
  @override
  Widget build(BuildContext context) {
    String idgroup = this.widget.idgroup;
    String gname = this.widget.namegroup;
    String iduser= this.widget.iduser;
    return Scaffold(
      appBar: AppBar(
        title: Text(gname),
        actions: <Widget>[
          //Widget para el desplegable add_group, Delete_group and profile
          Main_PopupMenu2(id: idgroup),
        ],
      ),
      //Codigo para la visualizacion del calendario acual
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
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
            .document(idgroup)
            .collection('assets')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Asset> assets = getAssets(docs);
          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Asset_Calendar(
                        idgroup: idgroup, idasset: assets[index].id, iduser: iduser),
                  ));
                },
                onLongPress: () {
                  assets.removeAt(index);
                  Firestore.instance.collection('group').document(idgroup).collection('assets').document(assets[index].id).delete();
                  // Firestore.instance.collection('event').document(event.value['eventid']).delete();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(assets[index].name),
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
