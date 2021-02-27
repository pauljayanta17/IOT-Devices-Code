import 'package:flutter/material.dart';
import 'package:led_blinking/homepage.dart';
import 'package:led_blinking/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    routes: {
      LoginPage.routename:(context)=>LoginPage(),
      HomePage.routename:(context)=>HomePage(),
    },
   );
  }
}

