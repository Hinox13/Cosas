import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    String idgroup = this.widget.group.id;
    String iduser = this.widget.iduser;
    String description = this.widget.group.description;
    List<dynamic> members = this.widget.group.user_list;
    String admin = this.widget.group.admin;

    return Scaffold(
      appBar: AppBar(title: Text('Group Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TitleDescription(),
            SizedBox(height: 15),
            TextDescription(idgroup: idgroup, groupdescription: description),
            SizedBox(height: 15),
            ListMembers(id: idgroup, iduser: iduser, admin: admin),
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
  String id, iduser, admin;

  ListMembers({
    Key key,
    @required this.id,
    @required this.iduser,
    @required this.admin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where('group', arrayContains: id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      contentPadding: EdgeInsets.all(20),
                      title: Text('Status of ${users[index].name}'),
                      content: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Text(users[index].status),
                        ),
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  if (iduser == admin) {
                    Firestore.instance
                        .collection('users')
                        .document(users[index].id)
                        .updateData({
                      "group": FieldValue.arrayRemove([id])
                    });

                    Firestore.instance
                        .collection('group')
                        .document(id)
                        .updateData({
                      "members": FieldValue.arrayRemove([users[index].id])
                    });
                  } else {
                     Fluttertoast.showToast(
                  msg: "Unauthorized action! You are not the admin of this group",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 12.0);
                  }
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
