import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';

class Group_Layout extends StatefulWidget {
  @override
  Group_Layout(String id);
  _Group_LayoutState createState() => _Group_LayoutState();
}

class _Group_LayoutState extends State<Group_Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Name'),
        actions: <Widget>[
          //Widget para el desplegable add_group, Delete_group and profile
          Main_PopupMenu(),
        ],
      ),
      //Codigo para la visualizacion del calendario acual
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: InkWell(
        child: Container(
          height: 200,
          color: Colors.purple,
          child: Text('Assetmos algo o que?'),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => User_Calendar()));
        },
      ),
    );
  }
}
