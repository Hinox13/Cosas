import 'dart:async';
import 'dart:core';
import 'package:projecte_visual/Layout/Asset_Calendar/Reserva.dart';
import 'package:projecte_visual/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';
import 'package:table_calendar/table_calendar.dart';

class Asset_Calendar extends StatefulWidget {
  String idgroup,idasset,iduser;
  Asset_Calendar({this.idgroup, this.idasset, this.iduser});
  @override
  _Asset_CalendarState createState() => _Asset_CalendarState();
}

class _Asset_CalendarState extends State<Asset_Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  List<DateTime>time;
  void initState() {
    final _selectedDay = today();
     _selectedEvents = _events[today()] ?? [];
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
 DateTime select;

  @override
  Widget build(BuildContext context) {
    String idgroup=this.widget.idgroup;
    String idasset=this.widget.idasset;
    String iduser= this.widget.iduser;
  
 //////////////////////////////////////////////////////////////////////

//Revisar no es guarda el valor de document['name] en name
//La instancia però es la correcta mireu el DEBUG CONSOLE
// El problema està en la variable que en algun moment perd la referencia del valor
//intentar implementar amb les clases
    Widget buildEventList(DateTime select) {
      
      return ListView(
          children: _selectedEvents.asMap().entries.map((event) {
        int idx = event.key;
        String name;

      Firestore.instance.collection('users').document('${event.value['userid']}').get().then(
          (document) {
            name=document['name'];
            print(name);
          });
        

        print(name);
        
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            
            title: Text('$name'),
            onTap: () => print(event.value),
            onLongPress: () {
              setState(() {
                _selectedEvents.removeAt(idx);
                Firestore.instance.collection('event').document(event.value['eventid']).delete();
              });
            },
          ),
        );
      }).toList());
    }
///////////////////////////////////////////////////////////////////////////

    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Calendar'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('event')
            .where('assetid', isEqualTo: idasset)
            .snapshots(), //Filtrem de firebase només els que tenen la id que ens interessen
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> docs = snapshot.data.documents; //No ha petao
          List<Event> events = docaEvent_list(docs);
          _events.clear();
          for (var eve in events){
            addEvent(eve.init,{'userid': eve.userid, 'eventid': eve.eventid}, _events);
          }

          return Column(children: <Widget>[
            TableCalendar(
              calendarController: _calendarController,
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Colors.deepPurple,
                selectedColor: Colors.pink,
              ),
              onDaySelected: (date, events) {
              
               
                print(events);
                setState(() {
                    select = date;
                     print(select.toString());
                  _selectedEvents = events;
                }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
                //en format DateTame només s'haurà de filtrar
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(child: buildEventList(select)),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print(select.toString());
            setState(() {
              inReserve(context,time,idgroup,idasset,iduser,select);
            });
          }),
    );
  }
}
