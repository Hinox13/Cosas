
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssetList extends StatefulWidget {
  @override
  _AssetListState createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
  
      body: StreamBuilder(
        stream: Firestore.instance.collection('group/iVOGHEIQKJpdFeWhnGrU/assets').snapshots(), //iVOGHEIQKJpdFeWhnGr es el id de cada llis
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;

       
          return ListView.builder(
            itemCount: docs.length ,
            itemBuilder: (context, index){
            Map<String, dynamic> data = docs[index].data;

            return ListTile(
              leading: CircleAvatar(),
              title: Text(data['name']),
             onTap: (){
             
             }
            );
            }
          );

          
          //Text('${docs[0].data['name']}');
        },
      ),
    );
  }
}
