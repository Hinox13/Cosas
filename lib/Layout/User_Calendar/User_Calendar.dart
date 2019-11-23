
/*
Tal i com esta plantejat actualment, aqui seria un calendari nomes per visualitzar les reserves del propi usuari,
pero si per base de dades fem arribar totes les reserves podem automatitzarho i aprofitar l'estructura per
reserva de grups, on passem com a parametres les reserves d'un individu o be un pupurri de reserves
OJOOOO => perque no ho farem aixi?, es lleugerament diferent un scaffold de laltre ja que un e un floating 
action button per afegir events i el actualment mostrat nomes serveix per visualitzar.
*/
import 'package:flutter/material.dart';

class User_Calendar extends StatefulWidget {
  @override
  _User_CalendarState createState() => _User_CalendarState();
}

class _User_CalendarState extends State<User_Calendar> {
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
          child: Placeholder(),
        ),
      ),
    );
  }
}
