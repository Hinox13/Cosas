import 'dart:core';
import 'package:projecte_visual/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/funcions.dart';
import 'package:table_calendar/table_calendar.dart';

class User_Calendar extends StatefulWidget {
  String idgroup, idasset, iduser;
  User_Calendar({this.idgroup, this.idasset, this.iduser});
  @override
  _User_CalendarState createState() => _User_CalendarState();
}

class _User_CalendarState extends State<User_Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  List<DateTime> time;
  String name;
  String gname;
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
    String iduser = this.widget.iduser;

    Widget buildEventList(DateTime select, List<Event> events) {
      return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          dynamic e = _selectedEvents[index];
          List<dynamic> grups;

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('group')
                  .document('${e['groupid']}')
                  .collection('assets')
                  .document('${e['assetid']}')
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshoti) {
                if (!snapshoti.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                DocumentSnapshot docos = snapshoti.data;
                String nameasset = docos.data['name'];
                //docos.data['name'];

                return Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: StreamBuilder(
                      stream: Firestore.instance
                          .collection('group')
                          .document('${e['groupid']}')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshoti) {
                        if (!snapshoti.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        DocumentSnapshot docos = snapshoti.data;
                        String groupasset = docos.data['name'];

                        return Text('$nameasset from $groupasset.');
                      },
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('From: ${e['init'].hour}:${e['init'].minute}'),
                        Text('To: ${e['end'].hour}:${e['init'].minute}'),
                        SizedBox(width: 20),
                      ],
                    ),
                    onTap: () {
                      print('${e['assetid']}');
                      print('${e['groupid']}');
                    },
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
///////////////////////////////////////////////////////////////////////////

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Calendar'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('event')
            .where('userid', isEqualTo: iduser)
            .snapshots(), //Filtrem de firebase només els que tenen la id que ens interessen
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Event> events = docaEvent_list(docs);
          _events.clear();
          for (var eve in events) {
            addEvent(
                yearmonthday(eve.init),
                {
                  'userid': eve.userid,
                  'assetid': eve.assetid,
                  'init': eve.init,
                  'end': eve.end,
                  'groupid': eve.groupid
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
                setState(() {
                  select = date;
                  _selectedEvents = events;
                }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
                //en format DateTame només s'haurà de filtrar
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(child: buildEventList(select, events)),
          ]);
        },
      ),
    );
  }
}
