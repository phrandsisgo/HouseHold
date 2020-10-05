import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';

class Anmeldung extends StatefulWidget {
  @override
  _AnmeldungState createState() => _AnmeldungState();
}

class _AnmeldungState extends State<Anmeldung> {
  final AuthService _firebaseAuth = AuthService();
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
                decoration: textInputDecoration.copyWith(hintText: 'email'),
              ),
              SizedBox(
                height: 40,
              ),
              Text('password'),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Anmelden'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      )),
    );
  }
}
