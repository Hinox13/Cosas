import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:projecte_visual/Layout/User_Calendar/AddEvent.dart';
import 'package:table_calendar/table_calendar.dart';

class User_Calendar extends StatefulWidget {
  @override
  _User_CalendarState createState() => _User_CalendarState();
}

class _User_CalendarState extends State<User_Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;

  /*addEvent(DateTime date, String name) {
    if (_events.containsKey(date)) {
      _events[date].add(name);
    } else {
      _events[date] = [name];
    }
    ID BATERIA 2XaGydRA9dYh0ePMDwoc
  }*/

  void initState() {
    final _selectedDay = today();
    Firestore.instance.collection('event').snapshots();
    AsyncSnapshot<QuerySnapshot> snapshot;
    List<DocumentSnapshot> eventsfire = snapshot.data.documents;
    _events = {};
    for (int i = 0; i < eventsfire.length; i++) {}

    _selectedEvents = _events[today()] ?? [];

    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime select;

    Widget buildEventList(DateTime select) {
      return ListView(
          children: _selectedEvents.asMap().entries.map((event) {
        int idx = event.key;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(event.value),
            onTap: () => print(event.value),
            onLongPress: () {
              setState(() {
                _selectedEvents.removeAt(idx);
              });
            },
          ),
        );
      }).toList());
    }
String idasset = '2XaGydRA9dYh0ePMDwoc';
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Calendar'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('events')
            .where('assetid', isEqualTo: idasset)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;
          //List<Event> events = kdjdkjfsdkfj(docs);


          return Column(children: <Widget>[
            TableCalendar(
              calendarController: _calendarController,
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Colors.deepPurple,
                selectedColor: Colors.pink,
              ),
              onDaySelected: (date, events) {
                select = date;
                print(events);
                setState(() {
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
            print('hey');
            setState(() {
              addEvent(select, 'bla', _events);
            });
          }),
    );
  }
}

/*

StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return Column(children: <Widget>[
        TableCalendar(
          calendarController: _calendarController,
          events: _events,
          calendarStyle: CalendarStyle(
            todayColor: Colors.deepPurple,
            selectedColor: Colors.pink,
          ),
          onDaySelected: (date, events) {
           select=date;
            print(events);
            setState(() {
            
              _selectedEvents = events;
            }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
            //en format DateTame només s'haurà de filtrar
          },
        ),
        const SizedBox(height: 8.0),
        Text('Polla en vinagre'),
        Expanded(child: buildEventList(select)),
      ]),
        },
      ),
*/
