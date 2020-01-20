import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id, name, status;
  List<dynamic> group;

  User(this.id, this.name, this.status,this.group);
}

///////////////////////////////CLASSE D'ASSETS/////////////////////////////////
class Asset {
  String name, id;

  Asset(this.id, this.name);
}

/////////////////////////////////////////////////////////////////////////////////
///
///////////////////////////////CLASSE D'EVENTS/////////////////////////////////
class Event {
  String userid, assetid, eventid, groupid;
  DateTime init, end;
  Event(this.userid, this.assetid, this.init, this.end, this.groupid, {this.eventid});
  Event.fromFirestore(Map<String, dynamic> doc, String index)
      : userid = doc['userid'],
        assetid = doc['assetid'],
        eventid = index,
        init = doc['init'],
        end = doc['end'];
  Map<String, dynamic> toFirestore() {
    return {
      'assetid': assetid,
      'end': Timestamp.fromDate(end),
      'init': Timestamp.fromDate(init),
      'userid': userid,
      'groupid' : groupid,
    };
  }
}
/////////////////////////////////////////////////////////////////////////////////

///////////////////////CLASSE DE GROUPS/////////////////////////////////////////
class Group {
  String name, admin, id, description;
  List user_list;
  

  Group(this.name, this.admin, this.id, this.user_list, this.description);

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'admin': admin,
      'members' : user_list,
    };

    
  }
}
///////////////////////////////////////////////////////////////////////////////
