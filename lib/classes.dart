import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  String id, name, status;

  User(this.id, this.name, this.status);
}

class Asset {
  String name;

  Asset(this.name);
}

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

class Invent {
  String userid, assetid, eventid;
  DateTime init, end;
  DocumentReference reference;

  Invent.fromMap(Map<String,dynamic> map, {this.reference})
  : userid = map['userid'],
  assetid = map['assetid'],
  eventid = map['eventid'];
}

///////CONVERSIO DEL FIREBASE A LLISTA D'EVENTS////////////
List<Event> docaEvent_list(List<DocumentSnapshot> doc) {
  List<Event> event_list = [];
  //Event evento;
  String eventid;
  for (var docu in doc) {
    eventid = docu.documentID;
    event_list.add(Event(docu.data['userid'], docu.data['assetid'], docu.data['init'].toDate(), docu.data['end'].toDate(),eventid));
  }
  return event_list;
}
/////////////////////////////////////////////////////////

class Group {
  String name, admin, id;
  List<User> user_list;

  Group(this.name, this.admin, this.id, this.user_list);
}