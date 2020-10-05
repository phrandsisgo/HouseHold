import 'package:flutter/material.dart';
//import 'package:kuehlschrank_app/Screens/NeuRegistrierung.dart';
import 'package:kuehlschrank_app/Screens/Wrapper.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';
import 'package:provider/provider.dart';

import 'Models/Users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
