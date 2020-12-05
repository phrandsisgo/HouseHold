//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';

class Anmeldung extends StatefulWidget {
  @override
  _AnmeldungState createState() => _AnmeldungState();
}

class _AnmeldungState extends State<Anmeldung> {
  final AuthService _firebaseAuth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = ' ';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Anmeldung'),
      ),
      body: Center(
          child: Container(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                  'Herzlich willkommen, bitte gib uns deine Daten An um dich anzumelden.'),
              SizedBox(
                height: 30,
              ),
              Text('Email'),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'EnteranEmail' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              Text('Password'),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                ),
                validator: (val) =>
                    val.length < 6 ? 'Enter an Password 6 Zeichen' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Anmelden'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _firebaseAuth.anmeldungMitEmail(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'please give valid credentials';
                      });
                    } else {
                      print(result.uid);

                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
