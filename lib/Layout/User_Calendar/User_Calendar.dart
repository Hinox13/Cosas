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
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
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
 DateTime select;

    Widget buildEventList(DateTime select) {
   
      return ListView(
        children: _selectedEvents.asMap().entries
            .map((event) {
            int idx = event.key;
           return  Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(event.value),
                    onTap: () => print(event.value),
                    onLongPress: (){
                      setState((){ _selectedEvents.removeAt(idx);}
                      );

                    },
                    
                  ),
                );}).toList()
            
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
           select=date;
            print(events);
            setState(() {
            
              _selectedEvents = events;
            }); //FIREBASE: En aquesta part es descargarn els events que te guardat el asset seleccionat. Com que tenim la variable date que ens diu el dia
            //en format DateTame només s'haurà de filtrar
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(child: buildEventList(select)),
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
