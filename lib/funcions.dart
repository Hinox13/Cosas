// ARXIU DE LES FUNCIONS QUE ES FAN SERVIR
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_visual/classes.dart';
import 'dart:core';
import 'package:flutter/material.dart';

///////CONVERSIO DEL FIREBASE A LLISTA D'EVENTS/////////////////////////////////
List<Event> docaEvent_list(List<DocumentSnapshot> doc) {
  List<Event> event_list = [];
  String eventid;
  for (var docu in doc) {
    eventid = docu.documentID;
    event_list.add(Event(docu.data['userid'], docu.data['assetid'], docu.data['init'].toDate(), docu.data['end'].toDate(),eventid:eventid));
  }
  return event_list;
}

////////  Un altre manera de pasar de Snapshots de Firebase a Classes EVENT /////////////////////////////

List<Event> doc2Event (List<DocumentSnapshot> doc){
  List<Event> out =[];
  for (var docs in doc){
    out.add(new Event(docs.data['userid'],docs.data['assetid'],docs.data['init'].toDate(),docs.data['end'].toDate(),eventid: docs.documentID));
  }
  return out;
}
///
///////CONVERSIO DEL FIREBASE A LLISTA DE GRUPS/////////////////////////////////
List<Group> docaGrup_list(List<DocumentSnapshot> doc) {
  List<Group> group_list= [];
  for (var docu in doc) {
    group_list.add(Group(docu.data['name'], docu.data['admin'], docu.documentID, docu.data['members'], docu.data['description']));
  }
  return group_list;
}
/////////////////////////////////////////////////////////////////////////////////
///
///////CONVERSIO DEL FIREBASE A LLISTA DE USERS/////////////////////////////////
List<User> docaUser_list(List<DocumentSnapshot> doc) {
  List<User> user_list = [];
  for (var docu in doc) {
    user_list.add(User(docu.documentID, docu.data['name'], docu.data['status']));
  }
  return user_list;
}
/////////////////////////////////////////////////////////////////////////////////
//    Intento de conseguir la subcolección      //
//    La cosa es que paseu la llista de         // 
//    DocumentSnapshots del grup                //
List<Asset> getAssets(List<DocumentSnapshot> docs){
  List<Asset> assets = [];
  for (var docu in docs){
    assets.add(new Asset(docu.documentID,docu.data['name']));
  }
  return assets;
}

////////////////////////////////////////////////////////////////////////////////////
//    Trec del grup en el que estem dins       //
//    la matriu de membres                     //
//    ens permét construir després la llista 
//    d'usuaris d'aquell grup                  //
 llistamembres(String idgroup,String info){
   List<String> members;
  Firestore.instance.collection('group').document(idgroup).get().then((doc){
     info=doc['description'];
     members = doc['members'];
   });
   return members;
 }

////////////////////////////////////////////////////////////////////////////////////
///   Passo la data el nom de la reserva i la llista amb la que visualitzare les reserves//
///   Miro a la matriu si la data ja existeix, si existeix afegeixo la reserva, si no creo la data i afegeixo
/// 
addEvent(DateTime date, String reserve, Map<DateTime, List> events) {
DateTime dating = new DateTime.utc(date.year,date.month,date.day);
  if (events.containsKey(dating)) {
    events[dating].add(reserve);
  } else {
    events[dating] = [reserve];
  }
}

//////////////////////////////////////////////////////////////////////////
///   Petita funcio que crea el dia actual en Datetime i l'inicialitza a les 00:00:00
DateTime today() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}


////////////////////////////////////////////////////////
/// FUNCIÓ PER TENIR NOMÉS TENIR LA DATA (Year:Month,Day)
 DateTime  yearmonthday(DateTime t){
            return DateTime(t.year,t.month,t.day);
          }

///////////////////////////////////////////////////
/// Funció per simplifacar qui ha fet la reserva
/* està en procés
Map<String,String> who(List<User> userlist){

    userlist['userid']: 

  

}

*/
