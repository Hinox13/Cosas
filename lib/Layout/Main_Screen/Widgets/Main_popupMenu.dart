
import 'package:flutter/material.dart';

class Main_PopupMenu extends StatelessWidget {
  const Main_PopupMenu({
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
                child: Text("Afegir grup"),
              ),
              PopupMenuItem(
                value: 'Eliminar',
                child: Text("Eliminar grup"),
              ),
              PopupMenuItem(
                value: 'Perfil',
                child: Text("Perfil"),
              ),
            ],
        //Creacion de que hacer con el valor obtenido
        onSelected: (value) {
          switch (value) {
            case 'Afegir':
              {
                print('Afegir');
              }
              break;
            case 'Eliminar':
              {
                print('Eliminar');
              }
              break;
            case 'Perfil':
              {
                print('Perfil');
              }
              break;
            default:
              {}
          }
        });
  }
}