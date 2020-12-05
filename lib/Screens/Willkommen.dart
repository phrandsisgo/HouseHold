import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Screens/NeuRegistrierung.dart';
import 'package:kuehlschrank_app/Screens/SignIn.dart';
import 'package:kuehlschrank_app/Services/FirebaseFunctions.dart';

class Willkommen extends StatelessWidget {
  String nickname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Willkommen'),
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            //unten kommt der Titel
            Text(
              'Willkommen ',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 20,
              ),
            ),
            Icon(Icons.panorama),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              child:
                  Text('In dieser App kannst du deine Lebensmittel verwalten.'),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Besitzt du bereits ein Konto bei uns?',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 20,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push<Widget>(
                    context,
                    MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => Anmeldung()));
              },
              child: Text('Anmeldung'),
              color: Colors.red,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Oder willst du dich Registrieren?',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push<Widget>(
                    context,
                    MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => NeuRegistrierung()));
              },
              child: Text('Registrierung.'),
              color: Colors.red,
            ),
            RaisedButton(onPressed: (){
              FirebaseFunctionsCloud().changeConsole();
              
          //    FirebaseFunctionsCloud().newHaushalt('hello haushaltsname','yikes die UID');
           //   print('newHaushalt aufgerufen');
              
            },
            child: Text('callable'),)
          ],
        ),
      )),
    );
  }
}
