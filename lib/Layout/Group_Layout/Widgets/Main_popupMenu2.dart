
import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Add_Group/Add_Group.dart';
import 'package:projecte_visual/Layout/Group_Info/Group_Info.dart';

class Main_PopupMenu2 extends StatelessWidget {
 final String idgroup;
  const Main_PopupMenu2( {
    this.idgroup,
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
            case 'Afegir ':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Group()));
              }
              break;
            case 'Eliminar':
              {
                print('Eliminar');
              }
              break;
            case 'Info':
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Group_Info(idgroup)));
              }
              break;
            default:
              {}
          }
        });
  }
}