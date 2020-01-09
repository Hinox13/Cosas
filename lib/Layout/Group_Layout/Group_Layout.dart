import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Add_Asset/Add_Asset.dart';
import 'package:projecte_visual/Layout/Group_Layout/Widgets/Main_popupMenu2.dart';
import 'package:projecte_visual/Layout/Asset_Calendar/Asset_Calendar.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

////////////////////EL QUE HI HA EN EL GRUP SELECCIONAT//////////////////////////
class Group_Layout extends StatefulWidget {
  final String iduser;
  Group group;
  Group_Layout({this.iduser, this.group});
  @override
  _Group_LayoutState createState() => _Group_LayoutState();
}

class _Group_LayoutState extends State<Group_Layout> {
  @override
  Widget build(BuildContext context) {
    String idgroup = this.widget.group.id;
    String gname= this.widget.group.name;
     String iduser = this.widget.iduser;
    Group group = this.widget.group;
   
   
    return Scaffold(
      appBar: AppBar(
        title: Text(gname),
        actions: <Widget>[
          //Widget para el desplegable add_group, Delete_group and profile
          Main_PopupMenu2(iduser:iduser, group: group ),
         
        ],
      ),
      //Codigo para la visualizacion del calendario acual
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Add_Asset(idgroup)));
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
                        idgroup: idgroup,
                        idasset: assets[index].id,
                        iduser: iduser),
                  ));
                },
                onLongPress: () {
                  assets.removeAt(index);
                  Firestore.instance
                      .collection('group')
                      .document(idgroup)
                      .collection('assets')
                      .document(assets[index].id)
                      .delete();
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
