import 'dart:async';

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
  }*/


  void initState() {
    final _selectedDay = today();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event 1422432432',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
  _selectedEvents =_events[today()] ?? [];

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
 

    Widget buildEventList() {
      print(_selectedEvents);
      return ListView(
        children: _selectedEvents
            .map((event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(event.toString()),
                    onTap: () => print('$event tapped!'),
                  ),
                ))
            .toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Calendar'),
      ),
      body: Column(children: <Widget>[
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
              _selectedEvents = events;
            }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
            //en format DateTame només s'haurà de filtrar
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(child: buildEventList()),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('hey');
            setState(() {
              addEvent(today(), 'bla', _events);
            });
          }),
    );
  }
}
