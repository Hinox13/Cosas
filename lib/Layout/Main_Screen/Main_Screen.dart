
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RoomShare'),
        actions: <Widget>[
          //Widget para el desplegable
          Main_PopupMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => User_Calendar(),
            )
          );
        },
      ),
    );
  }
}