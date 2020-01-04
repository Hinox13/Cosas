import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projecte_visual/Layout/Main_Screen/Main_Screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 //TextEditingController _controlpassword,_controlemail;
  String _password, _email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
/*
  @override
  void initState() {
    _controlpassword = TextEditingController();
    _controlemail = TextEditingController();
    super.initState();
  }
*/
//Nota: implemento el  TextFormField perque ens permét validar
// info: https://flutter.dev/docs/cookbook/forms/validation
//concepte bàsic ---> Form() permét validar el contingut dels TextFormFields



Future<void> signIn()async{
    final formState= formKey.currentState;
  if(formState.validate()){
    formState.save();
    FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email:_email, password:_password);
    print(user.providerId);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen(user:user)));
  }else{print('no valido ${_email}, ${_password}');}

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body:Form(
          key:formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
               // controller:  _controlemail,
                validator:(input) {
                  if (input.isEmpty) {
                    return 'Please, type the required email';
                  }else return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
           
                //controller: _controlpassword,
                obscureText: true,
                validator: (input) {
                  if (input.length >2) {
                    return 'est';
                  }else return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Pasword',
                ),
                
              ),
              RaisedButton(
                onPressed:signIn,
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      
    );
  }

}