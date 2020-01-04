

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _password, _email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Sign in'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key:formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
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
                  obscureText: true,
                  validator: (input) {
                    if (input.length <6) {
                      return 'Please The password needs minimum 6 characters';
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

                RaisedButton(
                  onPressed:(){
                    
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ),
      ),
      
      
    );
  }

  Future<void> signIn()async{
  FormState formState= formKey.currentState;
  if(formState.validate()){
    print('valid');
    formState.save();
    try{
    FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email:_email, password:_password);
    print(user.uid);
    Navigator.of(context).pop();
    }catch(e){print(e.toString());}
  }else{print('no valido ${_email}, ${_password}');}

}


}
