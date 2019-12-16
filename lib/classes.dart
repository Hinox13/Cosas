class User {
 String id, name, status;

 User(this.id, this.name, this.status)
;

}

class Asset {
 String name;

 Asset(this.name);
}

class Event {
 String userid;
 DateTime init, end;
 
 Event(this.userid, this.init, this.end);
 
}

class Group {

 String name,admin,id;  
 List<User> user_list;

 Group(this.name, this.admin, this.id, this.user_list);

}
