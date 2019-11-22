import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomShare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

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
            PopupMenuButton<String>(
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
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.calendar_today),
          onPressed: () {},
        ));
  }
}
