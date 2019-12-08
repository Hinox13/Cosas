import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Class/Models.dart';
import 'package:projecte_visual/Layout/Main_Screen/Widgets/Main_popupMenu.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';

class Group_Layout extends StatefulWidget {
  @override
  _Group_LayoutState createState() => _Group_LayoutState();
}



class _Group_LayoutState extends State<Group_Layout> {

  TextEditingController _controller;

  @override
  void initState() {
    _controller= TextEditingController();
    super.initState();
  }


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
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(                  
              titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text('Asset'),
              content: Column(
                children: <Widget>[                     //Creació de dos T
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Asset Name ',
                    ),
                    controller: _controller,
                  ),
                ],
              ),

              actions: <Widget>[                                 
                FlatButton(
                  child: Text('Crear'),
                  onPressed: () {                               
                    Navigator.of(context).pop(_controller.text);          
                    _controller.clear();                                 
                  },
                ),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {               
                    Navigator.of(context).pop();   
                    _controller.clear();            
                  },
                ),
              ],
            ),
          ).then((value) {                                
            setState(() {                                 
                lassets.add(Asset(value));
              
            });
          });
        },
      ),
      

      body: ListView.builder(                                       
        padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: lassets.length,                                     
        itemExtent: 150,                                       
        itemBuilder: (context, index) => InkWell(           
          child: ListTile(                                
              contentPadding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(lassets[index].nomAsset),        
              leading: GestureDetector(                     
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                                                        
                        height: 100, 
                                              
                         child:CircleAvatar(backgroundColor: Colors.purple,),   
                         ),       
                  onTap:  () {
                      Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => User_Calendar(), settings: RouteSettings(arguments: lassets[index])));
                  }
                  ),
          ),
                ),
              ),
    );
  }
}
