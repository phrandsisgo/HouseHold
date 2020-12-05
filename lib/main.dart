import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:kuehlschrank_app/Screens/NeuRegistrierung.dart';
import 'package:kuehlschrank_app/Screens/Wrapper.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';
import 'package:provider/provider.dart';

import 'Models/Users.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Benutzer>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
