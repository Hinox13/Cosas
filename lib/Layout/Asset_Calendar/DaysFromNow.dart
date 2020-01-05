import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int daysconversionfromfirebase(Timestamp initFirebase) {
Firestore.instance.collection('event').snapshots();
  AsyncSnapshot<QuerySnapshot> snapshot;
  List<DocumentSnapshot> docs = snapshot.data.documents;
  Map<String, dynamic> data = docs[0].data;
  var actual = DateTime.now();
  var pasada = data['init'].toDate();
  var diferencia_final;
  Duration difference = pasada.difference(actual);
  if (difference.inHours % 24 != 0) diferencia_final = difference.inDays - 1;
}

/*
      if(daysconversionfromfirebase(data['init'].toDate()) = 0){_
      _selectedDay.subtract(Duration(days: daysconversionfromfirebase(data['init'].toDate()))): [
        '${data['init'].toDate()}',
        '${data['end'].toDate()}',
        'Muzak'
      ],}*/
/*StreamBuilder(
            stream: Firestore.instance.collection('event').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              
                  return Column(
                    children: <Widget>[
                    Text('${DateTime.now()}'),
                    Text('${Timestamp.now()}'),
                    Text('${data['init']}'),
                    Text('${difference.inDays}'),
                    Text('$diferencia_final'),



            
                    ],
                  );
                 },   
          ),*/
          
/*
Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('event').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<DocumentSnapshot> docs = snapshot.data.documents;
                  Map<String, dynamic> data = docs.;
                  return Column(
                    children: <Widget>[
                    Text('${data['init']}'),
                    Text('${DateTime.daysPerWeek}'),
                    Text('${DateTime.now()}'),
            
                    ],
                  );
                 },   
          ),
        ],
      ),
StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context,index){
              Map<String, dynamic> data = docs[index].data;
              return ListTile(
                title: Text(data['Name']),
              );
            },
          );
        },
      ),
      */
      
/*
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
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context,index){
              Map<String, dynamic> data = docs[index].data;
              return ListTile(
                title: Text(data['Name']),
              );
            },
          );
        },
      ),
    );
  }
}

  */