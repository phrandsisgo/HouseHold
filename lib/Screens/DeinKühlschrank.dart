import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';

class DeinKuehlschrank extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Ihr Kühlschrank'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Hier kommt noch eine Liste mit allen Lebensmittel rein.'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Hier kannst du dich abmelden',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                await _firebaseAuth.abmeldung();
              },
              child: Text('Abmeldung'),
            ),
          ],
        ),
      ),
    );
  }
}
