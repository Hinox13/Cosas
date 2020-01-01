import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

///////////////////////////////////////////////
///   Scaffold del Group_Info  ////////////////

class Group_Info extends StatefulWidget {
  final String idgroup;
  Group_Info(this.idgroup);
  @override
  _Group_InfoState createState() => _Group_InfoState();
}

class _Group_InfoState extends State<Group_Info>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String idgroup = this.widget.idgroup;
    String description;
    List<dynamic> members;

    llistamembres(idgroup, members, description);

    return Scaffold(
      appBar: AppBar(title: Text('Group Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TitleDescription(),
            SizedBox(height: 15),
            TextDescription(idgroup: idgroup),
            SizedBox(height: 15),
            ListMembers(members: members),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////
///  Titol Descscripció del grup /////////////////////////
class TitleDescription extends StatelessWidget {
  const TitleDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Group Description',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),);
  }
}

///////////////////////////////////////////////////////////
/// Text de descripció del firebase////////////////////////
class TextDescription extends StatelessWidget {
  const TextDescription({
    Key key,
    @required this.idgroup,
  }) : super(key: key);

  final String idgroup;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          height: 10,
          child: StreamBuilder(
            stream: Firestore.instance.collection('group').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<DocumentSnapshot> docs = snapshot.data.documents;
              int index;
              for (int i = 0; i < docs.length; i++) {
                //No he trobat forma per accedir directament a la descripció del group amb el Stream Builder
                if (docs[i].documentID == idgroup) index = i;
              }
              return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(docs[index].data['description']),
                  ));
            },
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
///   LLista dels membres del grup seleccionat   ////////////////

class ListMembers extends StatelessWidget {
  const ListMembers({
    Key key,
    @required this.members,
  }) : super(key: key);

  final List members;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where('users', arrayContains: members)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<User> users = docaUser_list(docs);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.all(20),
                        title: Text('Status of ${users[index].name}'),
                        content: 
                      
                 Container(height: 250,
                          width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:15.0, vertical:15),
                              child: Text(users[index].status),
                            ),
                          
                        )),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(users[index].name),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      users[index].status, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
