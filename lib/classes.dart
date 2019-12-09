class User {
 String name, state;
 final dynamic id;

 User(this.name, this.state, this.id)
;

}

class Asset {
 String name;
 List<Event> event_list;                //Cada Asset tindrà una llista amb les diferents reserves (Events)

 Asset(this.name, this.event_list);
}

class Event {
 final dynamic user_id;                 //Per saber quin usuari l'ha creat
 final dynamic asset_id;                //Per saber quin quin tipus d'asset s'ha reservat
 var init_date, end_date;               //Temps d'inici i finalització
 bool visible;                          //Per quan fem el calendari personal que filtri els events i es mostrin les reserves del usuari
 
 Event(this.user_id, this.asset_id ,this.init_date, this.end_date): this.visible=false;
 
}

class Group {

 String name,admin;                     //nom del grup i del administrador (User.name)
 final dynamic id;            
 List<User> user_list;
 List<Asset> asset_list;
 

 Group(this.name, this.admin, this.id, this.user_list, this.asset_list);

}
