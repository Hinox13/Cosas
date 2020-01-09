import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';

///////////////////////////////////////////////
///   Scaffold del Group_Info  ////////////////

class Group_Info extends StatefulWidget {
  final String iduser;
   Group group;
  Group_Info({this.iduser, this.group});
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
    String id = this.widget.group.id;
    String description = this.widget.group.description;
    List<dynamic> members = this.widget.group.user_list;
    //print(members);
    //llistamembres(idgroup, members, description);

    return Scaffold(
      appBar: AppBar(title: Text('Group Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TitleDescription(),
            SizedBox(height: 15),
            TextDescription(idgroup: id, groupdescription: description),
            SizedBox(height: 15),
            ListMembers(members: llistamembres(idgroup, description)),
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
    return Center(
      child: Text(
        'Group Description',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
/// Text de descripció del firebase////////////////////////
class TextDescription extends StatelessWidget {
  String idgroup;
  String groupdescription;

  TextDescription({
    Key key,
    @required this.idgroup,
    @required this.groupdescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(groupdescription),
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
///   LLista dels membres del grup seleccionat   ////////////////

class ListMembers extends StatelessWidget {
   List<dynamic> members;

   ListMembers({
    Key key,
    @required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //members.add('OQQkPrCOGWUau2APBMrSpDWTGTp1');
    return Expanded(
      flex: 2,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('users').where('BytA25mHpncD2ZqLsrfsTvukfT43',arrayContains: members[0])
            //.where('users',arrayContainsAny: members)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          print(docs[0]);
          List<User> users = docaUser_list(docs);
         
          return ListView.builder(
            itemCount:users.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.all(20),
                      title: Text('Status of ${users[index].name}'),
                      content: Container(
                        height: 250,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Text(users[index].status),
                        ),
                      ),
                    ),
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
                      users[index].status,
                      overflow: TextOverflow.ellipsis,
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
