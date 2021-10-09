import 'package:flutter/material.dart';
import 'package:share_files/testPage.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
      routes: {
        TestPage.routename:(context)=>TestPage(),
      },
    );
  }
}