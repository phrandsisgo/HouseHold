import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Models/Officialdocumentation.dart';
import 'package:kuehlschrank_app/Models/yourhouseholds.dart';
class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Household '),
        actions: [],
      ),
      body:Center(child: 
 //     ListView(children:[
      //  Text('yay'),
        OfficialDocumentation(),
   //     Text('hello here'),
//      ],scrollDirection: Axis.vertical,),
      ),
    );
  }
}