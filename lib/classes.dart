import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  String id, name, status;

  User(this.id, this.name, this.status);
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
///
///////////////////////////////CLASSE D'ASSETS/////////////////////////////////
class Asset {
  String name;

  Asset(this.name);
}
/////////////////////////////////////////////////////////////////////////////////
///
///////////////////////////////CLASSE D'EVENTS/////////////////////////////////
class Event {
  String userid, assetid, eventid;
  DateTime init, end;
  Event(this.userid, this.assetid, this.init, this.end, this.eventid);
  Event.fromFirestore(Map<String, dynamic> doc, String index)
      : userid = doc['userid'],
        assetid = doc['assetid'],
        eventid = index,
        init = doc['init'],
        end = doc['end'];
}
/////////////////////////////////////////////////////////////////////////////////

class Invent {
  String userid, assetid, eventid;
  DateTime init, end;
  DocumentReference reference;

  Invent.fromMap(Map<String,dynamic> map, {this.reference})
  : userid = map['userid'],
  assetid = map['assetid'],
  eventid = map['eventid'];
}

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
/////////////////////////////////////////////////////////////////////////////////
///
///////////////////////CLASSE DE GROUPS/////////////////////////////////////////
class Group {
  String name, admin, id;
  List user_list;

  Group(this.name, this.admin, this.id, this.user_list);
}
///////////////////////////////////////////////////////////////////////////////
///
///////CONVERSIO DEL FIREBASE A LLISTA DE GRUPS/////////////////////////////////
List<Group> docaGrup_list(List<DocumentSnapshot> doc) {
  List<Group> group_list = [];
  for (var docu in doc) {
    group_list.add(Group(docu.data['name'], docu.data['admin'], docu.documentID, docu.data['members']));
  }
  return group_list;
}
/////////////////////////////////////////////////////////////////////////////////