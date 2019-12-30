import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

class Group_Info extends StatefulWidget {
  final String idgroup;
  Group_Info(this.idgroup);
  @override
  _Group_InfoState createState() => _Group_InfoState();
}

class _Group_InfoState extends State<Group_Info>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String idgroup=this.widget.idgroup;
     List<dynamic>members;
    llistamembres(idgroup, members);
     print(members);
    return Scaffold(
      appBar: AppBar(title: Text('Group Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Center(child: Text('Group Description')),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                    height: 10, decoration: BoxDecoration(color: Colors.black)),
              ),
            ),
            Expanded(
              flex: 3,
              child:SizedBox(height:30)/*StreamBuilder(
        stream: Firestore.instance
            .collection('group').documents(idgroup)

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          QuerySnapshot docs = snapshot.data;
          List<Asset> assets = getAssets(docs);

          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                 
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
      ), */
            ),
          ],
        ),
      ),
    );
  }
}


 