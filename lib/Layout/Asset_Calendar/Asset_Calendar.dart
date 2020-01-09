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
  final String idgroup, idasset, iduser;
  Asset_Calendar({this.idgroup, this.idasset, this.iduser});
  @override
  _Asset_CalendarState createState() => _Asset_CalendarState();
}

class _Asset_CalendarState extends State<Asset_Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  List<dynamic> _selectedEvents;
  List<DateTime> time;
  String name;
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
    String idgroup = this.widget.idgroup;
    String idasset = this.widget.idasset;
    String iduser = this.widget.iduser;

    Widget buildEventList(DateTime select, List<Event> events) {
      return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          dynamic e = _selectedEvents[index];

          return StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshoti) {
                if (!snapshoti.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DocumentSnapshot> docos = snapshoti.data.documents;
                List<User> users = docaUser_list(docos);
                for (var user in users) {
                  if (user.id == e['userid']) name = user.name;
                }
                return Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text('Reservation'),
                    leading: Text(name),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            'From: ${e['init'].hour}:${e['init'].minute}:${e['init'].second}'),
                        Text(
                            'To: ${e['end'].hour}:${e['end'].minute}:${e['end'].second}'),
                        SizedBox(width: 20),
                      ],
                    ),
                    onTap: () => print(e),
                    onLongPress: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: Text('Delete Events'),
                          content: Text(
                              'Are you sure you want to DELETE THE CLICKED EVENT?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                setState(() {
                                  _selectedEvents.removeAt(index);
                                  Firestore.instance
                                      .collection('event')
                                      .document(e['eventid'])
                                      .delete();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        },
      );
    }

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

          for (var eve in events) {
            addEvent(
                yearmonthday(eve.init),
                {
                  'userid': eve.userid,
                  'eventid': eve.eventid,
                  'init': eve.init,
                  'end': eve.end
                },
                _events);
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
                select = date;

                print(_selectedEvents);
                setState(() {
                  _selectedEvents = events;
                }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
                //en format DateTame només s'haurà de filtrar
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(flex: 2, child: buildEventList(select, events)),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print(select.toString());
            setState(() {
              inReserve(context, time, idgroup, idasset, iduser, select, _selectedEvents);
            });
          }),
    );
  }
}
