import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecte_visual/Layout/Login/Register.dart';
import 'package:projecte_visual/Layout/Main_Screen/Main_Screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _password, _email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//Nota: implemento el  TextFormField perque ens permét validar
// info: https://flutter.dev/docs/cookbook/forms/validation
//concepte bàsic ---> Form() permét validar el contingut dels TextFormFields

  Future<void> signIn() async {
    FormState formState = formKey.currentState;
    if (formState.validate()) {
      print('valid');
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print(user.uid);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainScreen(user: user)));
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error message! Your E-mail or password are incorrect!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
      }
    } else {
      print('no valido $_email, $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparte.me',
      color: Colors.white,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(120, 0, 120, 250),
                Color.fromARGB(150, 250, 200, 0),
                Color.fromARGB(250, 250, 150, 0),
                Color.fromARGB(180, 200, 0, 0),
              ],
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(10, 15),
                                blurRadius: 30),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            
                            SizedBox(height: 20),
                            Text(
                              'Sign In',
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please, type the required email';
                                } else
                                  return null;
                              },
                              onSaved: (input) => _email = input,
                              decoration: InputDecoration(
                                fillColor: Colors.white30,
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                labelText: 'E-mail',
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(),
                              ),
                            ),
                            SizedBox(height: 15),
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
                                fillColor: Colors.white30,
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Password',
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    color: Colors.orange,
                                    onPressed: signIn,
                                    child: Text('Login',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Expanded(
                                                              child: RaisedButton(
                                                              
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => SignUpScreen()));
                                    },
                                    child: Text('Register'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90.0,
                    left: .0,
                    right: .0,
                    child: Center(
                      child: CircleAvatar(
                       backgroundColor: Colors.orange,

                        radius: 50.0,
                        child: Container(
                                height: 75,
                                width: 75,
                                child: Image.asset('logo/logo.png')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
