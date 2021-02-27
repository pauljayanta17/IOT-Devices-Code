import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routename = '/homepage';
  HomePage({this.app});
  final FirebaseApp app;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.reference();
  bool loading;
  bool red;
  bool blue;
  bool yellow;
  bool green;
  Color red_box;
  Color green_box;
  Color blue_box;
  Color yellow_box;
  // bool firstTime_red;
  // bool firstTime_green;
  // bool firstTime_yellow;
  // bool firstTime_blue;
  @override
  void initState() {
    super.initState();
    loading = true;
    ref.once().then((DataSnapshot snapshot) {
      red = snapshot.value['LED_Lights']['RED']['RED'];
      yellow = snapshot.value['LED_Lights']['YELLOW']['YELLOW'];
      green = snapshot.value['LED_Lights']['GREEN']['GREEN'];
      blue = snapshot.value['LED_Lights']['BLUE']['BLUE'];
    red_box = red==true ? Colors.red : Colors.grey;
    blue_box = blue ==true ? Colors.indigo : Colors.grey;
    yellow_box = yellow==true ? Color.fromRGBO(225, 164, 42, 1): Colors.grey;
    green_box = green ==true ? Colors.green : Colors.grey;
      
      print(red);
      print(green);
      print(blue);
      print(yellow);
      print('Data : ${snapshot.value}\n');
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    // firstTime_red = false;
    // firstTime_blue = false;
    // firstTime_yellow = false;
    // firstTime_green = false;
  }

  @override
  Widget build(BuildContext context) {
    // final ref = referenceDatatSet.reference();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LED Blinking",
          style: TextStyle(fontSize: size.height * 0.026, color: Colors.yellow),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: size.height,
              width: size.width,
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //for red LED
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(color: red_box),
                        child: Text(
                          "RED",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03),
                        ),
                      ),
                      Switch(
                        value: red,
                        onChanged: (v) {
                          setState(() {
                            red = v;
                            red_box = (red_box == Colors.grey)
                                ? Colors.red
                                : Colors.grey;
                            print(v);
                            // if (firstTime_red == true) {
                            //   ref
                            //       .child('LED_Lights')
                            //       .child('RED')
                            //       .set(red)
                            //       .asStream();
                            //   setState(() {
                            //     firstTime_red = false;
                            //   });
                            // } else {}

                            ref
                                .child('LED_Lights')
                                .child('RED')
                                .update({'RED': red}).asStream();
                          });
                        },
                        activeColor: Colors.red,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  //for green LED
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(color: green_box),
                        child: Text(
                          "GREEN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03),
                        ),
                      ),
                      Switch(
                        value: green,
                        onChanged: (v) {
                          setState(() {
                            green = v;
                            green_box = (green_box == Colors.grey)
                                ? Colors.green
                                : Colors.grey;
                            print(v);
                            // if (firstTime_green == true) {
                            //   ref
                            //       .child('LED_Lights')
                            //       .child('GREEN')
                            //       .set(green)
                            //       .asStream();
                            // } else {}
                            ref
                                .child('LED_Lights')
                                .child('GREEN')
                                .update({'GREEN': green}).asStream();
                          });
                        },
                        activeColor: Colors.green,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  //for yellow LED

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(color: yellow_box),
                        child: Text(
                          "YELLOW",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03),
                        ),
                      ),
                      Switch(
                        value: yellow,
                        onChanged: (v) {
                          setState(() {
                            yellow = v;
                            yellow_box = (yellow_box == Colors.grey)
                                ? Color.fromRGBO(225, 164, 42, 1)
                                : Colors.grey;
                            print(v);
                            // if (firstTime_yellow == true) {
                            //   ref
                            //       .child('LED_Lights')
                            //       .child('YELLOW')
                            //       .set(yellow)
                            //       .asStream();
                            // } else {}
                            ref
                                .child('LED_Lights')
                                .child('YELLOW')
                                .update({'YELLOW': yellow}).asStream();
                          });
                        },
                        activeColor: Color.fromRGBO(225, 164, 42, 1),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  //for blue LED
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(color: blue_box),
                        child: Text(
                          "BLUE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03),
                        ),
                      ),
                      Switch(
                          value: blue,
                          onChanged: (v) {
                            setState(() {
                              blue = v;
                              blue_box = (blue_box == Colors.grey)
                                  ? Colors.indigo
                                  : Colors.grey;
                              print(v);
                              // if (firstTime_blue == true) {
                              //   ref
                              //       .child('LED_Lights')
                              //       .child('BLUE')
                              //       .set(blue)
                              //       .asStream();
                              // } else {}
                              ref
                                  .child('LED_Lights')
                                  .child('BLUE')
                                  .update({'BLUE': blue}).asStream();
                            });
                          },
                          activeColor: Colors.indigo)
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
