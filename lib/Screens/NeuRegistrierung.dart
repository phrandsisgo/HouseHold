import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';

class NeuRegistrierung extends StatefulWidget {
  @override
  _NeuRegistrierungState createState() => _NeuRegistrierungState();
}

class _NeuRegistrierungState extends State<NeuRegistrierung> {
  final AuthService _firebaseAuth = AuthService();

  final _formKey = GlobalKey<FormState>();
  //Text Feld Status
  String email = ' ';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Bitte Registrieren sie sich hier'),
      ),
      body: Center(
          child: Container(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                  'Herzlich willkommen, bitte gib uns deine Daten An um dich zu registrieren.'),
              SizedBox(
                height: 15,
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
                height: 15,
              ),
              Text('password'),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'password',
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
              Text('Please Register '),
              RaisedButton(
                child: Text('Registrieren (eingabe)'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _firebaseAuth.registrierenMitEmail(
                        email, password);

                    //  Navigator.pop(context);
                    if (result == null) {
                      setState(() {
                        error = 'please give valid email';
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
              RaisedButton(
                child: Text('Sign in anonymously'),
                onPressed: () async {
                  Navigator.pop(context);
                  dynamic result = await _firebaseAuth.anonAnmeldung();
                  print(result);
                  if (result == null) {
                    print('error accured');
                  } else {
                    print('signed in');
                    print(result.uid);
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
