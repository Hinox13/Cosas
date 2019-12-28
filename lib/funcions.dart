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
    event_list.add(Event(docu.data['userid'], docu.data['assetid'], docu.data['init'].toDate(), docu.data['end'].toDate(),eventid));
  }
  return event_list;
}

////////  Un altre manera de pasar de Snapshots de Firebase a Classes EVENT /////////////////////////////

List<Event> doc2Event (List<DocumentSnapshot> doc){
  List<Event> out =[];
  for (var docs in doc){
    out.add(new Event(docs.data['userid'],docs.data['assetid'],docs.data['init'].toDate(),docs.data['end'].toDate(),docs.documentID));
  }
  return out;
}
///
///////CONVERSIO DEL FIREBASE A LLISTA DE GRUPS/////////////////////////////////
List<Group> docaGrup_list(List<DocumentSnapshot> doc) {
  List<Group> group_list= [];
  for (var docu in doc) {
    group_list.add(Group(docu.data['name'], docu.data['admin'], docu.documentID, docu.data['members']));
  }
  return group_list;
}
/////////////////////////////////////////////////////////////////////////////////
///
///////CONVERSIO DEL FIREBASE A LLISTA DE USERS/////////////////////////////////
List<User> docaUser_list(List<DocumentSnapshot> doc) {
  List<User> user_list = [];
  for (var docu in doc) {
    user_list.add(User(docu.data['id'], docu.data['name'], docu.data['status']));
  }
  return user_list;
}
/////////////////////////////////////////////////////////////////////////////////
//    Intento de conseguir la subcolección      //
//    La cosa es que paseu la llista de         // 
//    DocumentSnapshots del grup                //
List<Asset> getAssets(String idgroup){
  Firestore.instance.collection('group').document(idgroup).collection('assets').snapshots();
  AsyncSnapshot<QuerySnapshot> snapshot; 
  List<DocumentSnapshot> docs = snapshot.data.documents;
  List<Asset> assets = [];
  for (var docu in docs){
    assets.add(new Asset(docu.documentID,docu.data['name']));
  }
  return assets;
}