import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Screens/DeinK%C3%BChlschrank.dart';
import 'package:kuehlschrank_app/Screens/Willkommen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Willkommen();
    } else {
      return DeinKuehlschrank();
    }
    //  return Willkommen();
  }
}
