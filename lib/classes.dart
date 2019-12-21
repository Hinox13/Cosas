class User {
 String id, name, status;

 User(this.id, this.name, this.status)
;

}

class Asset {
 String name, id;

 Asset(this.name);
}

class Event {
 String userid,assetid, id;
 DateTime init, end;
 
 Event(this.userid, this.init, this.end);
 Event.fromFirestore(Map<String, dynamic> doc)
 : userid = doc['userid'],
   assetid = doc['assetid'],
   init = doc['init'],
   end = doc['end'];
 
}

class Group {

 String name,admin,id;  
 List<User> user_list;

 Group(this.name, this.admin, this.id, this.user_list);

}