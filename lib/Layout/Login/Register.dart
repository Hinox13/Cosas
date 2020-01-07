import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _password, _email, _name;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please, type your nickname';
                  } else
                    return null;
                },
                onSaved: (input) => _name = input,
                decoration: InputDecoration(
                  labelText: 'Nickname',
                ),
              ),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please, type the required email';
                  } else
                    return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: (input) {
                  if (input.length < 6) {
                    return 'Please The password needs minimum 6 characters';
                  } else
                    return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: signUp,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    FormState formState = formKey.currentState;
    if (formState.validate()) {
      print('valid');
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        // user.sendEmailVerification();  per verificar la conta amb el correu
        print(user.uid);
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({"name": '$_name', "status": 'Sharing is caring!'});
        Navigator.of(context).pop();
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('no valido ${_email}, ${_password}');
    }
  }
}
