import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_visual/Layout/User_Calendar/AddEvent.dart';

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

///////CONVERSIO DEL FIREBASE A LLISTA D'EVENTS////////////
List<Event> docaEvent_list(List<DocumentSnapshot> doc) {
  List<Event> event_list = [];
  Event evento;
  Timestamp timeinit;
  Timestamp timeend;
  String freference;
  for (int i = 0; i < doc.length; i++) {
    timeinit = doc[i].data['init'];
    timeend = doc[i].data['end'];
    freference = doc[i].documentID;
    print(doc[i].data['userid']);
    print(doc[i].data['assetid']);
    print( timeinit.toDate());
    print(timeend.toDate());
    event_list.add(Event(doc[i].data['userid'], doc[i].data['assetid'], timeinit.toDate(), timeend.toDate(),freference));
    //event_list.add(evento);
  }
  return event_list;
}
/////////////////////////////////////////////////////////

class Group {
  String name, admin, id;
  List<User> user_list;

  Group(this.name, this.admin, this.id, this.user_list);
}
