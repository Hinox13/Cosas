
/*
Tal i com esta plantejat actualment, aqui seria un calendari nomes per visualitzar les reserves del propi usuari,
pero si per base de dades fem arribar totes les reserves podem automatitzarho i aprofitar l'estructura per
reserva de grups, on passem com a parametres les reserves d'un individu o be un pupurri de reserves
OJOOOO => perque no ho farem aixi?, es lleugerament diferent un scaffold de laltre ja que un e un floating 
action button per afegir events i el actualment mostrat nomes serveix per visualitzar.
*/
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Class/Models.dart';
import 'package:table_calendar/table_calendar.dart';

class User_Calendar extends StatefulWidget {
  @override
  _User_CalendarState createState() => _User_CalendarState();
}

class _User_CalendarState extends State<User_Calendar> {

  Asset asset;
  _User_CalendarState(this.asset);

  CalendarController  _calendarController;
  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('User Calendar'),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          child: TableCalendar(
            calendarController: _calendarController,
            calendarStyle: CalendarStyle(
              todayColor: Colors.deepPurple,
              selectedColor: Colors.pink,
              
            ),
            onDaySelected: (date, events) {                
              print('$date, $events');                     //funció que al clicar el calendari ens permet saber l'event i dia
            }
          
          ),
        ),
      ),
    );
  }
}


