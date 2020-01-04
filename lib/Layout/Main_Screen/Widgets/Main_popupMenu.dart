import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Add_Group/Add_Group.dart';
import 'package:projecte_visual/Layout/Profile/Profile.dart';

class Main_PopupMenu extends StatelessWidget {
  final String userid;
 
  const Main_PopupMenu({
    Key key,
    this.userid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        color: Colors.white,
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Afegir',
                child: Text("Add group"),
              ),
              PopupMenuItem(
                value: 'Eliminar',
                child: Text("Delete group"),
              ),
              PopupMenuItem(
                value: 'Perfil',
                child: Text("Profile"),
              ),
            ],
        //Creacion de que hacer con el valor obtenido
        onSelected: (value) {
          switch (value) {
            case 'Afegir':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Group(userid)));
              }
              break;
            case 'Eliminar':
              {
                print('Eliminar');
              }
              break;
            case 'Perfil':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile_Screen(userid)));
              }
              break;
            default:
              {}
          }
        });
  }
}