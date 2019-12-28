// ARXIU DE LES FUNCIONS QUE ES FAN SERVIR
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_visual/classes.dart';

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
  List<Event> out;
  for (var docs in doc){
    out.add(new Event(docs.data['userid'],docs.data['assetid'],docs.data['init'].toDate(),docs.data['end'].toDate(),docs.documentID));
    print(out);
  }
}

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
// List<Asset> subdocus(List<DocumentSnapshot> gru){
//   for(var grup in gru){
//     CollectionReference groupRef = grup.reference.collection('group');
//     List<DocumentSnapshot> productsnap = groupRef.getDocuments().grup();
//   }
// }