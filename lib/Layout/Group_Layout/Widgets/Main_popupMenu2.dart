import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Asset_Calendar/Add_User/Add_User.dart';
import 'package:projecte_visual/Layout/Group_Layout/Group_Info/Group_Info.dart';
import 'package:projecte_visual/classes.dart';


class Main_PopupMenu2 extends StatelessWidget {
 final String iduser;//id del group on estem
  Group group;
   Main_PopupMenu2( {
    this.iduser,
    this.group,
     Key key,
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
                child: Text("Add User"),
              ),
              PopupMenuItem(
                value: 'Eliminar',
                child: Text("Delete Asset"),
              ),
              PopupMenuItem(
                value: 'Info',
                child: Text("Group Info"),
              ),
            ],
        //Creacion de que hacer con el valor obtenido
        onSelected: (value) {
          switch (value) {
            case 'Afegir':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUser(group: group)));
              }
              break;
            case 'Eliminar':
              {
                print('Eliminar');
              }
              break;
            case 'Info':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Group_Info(iduser: iduser ,group: group)));
              }
              break;
            default:
              {}
          }
        });
  }
} 