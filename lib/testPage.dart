import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_access/wifi_access.dart';

class TestPage extends StatefulWidget {
  static const String routename = '/testpage';
  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  TextEditingController textEditingController = TextEditingController();
  double intensity=100;
  String up="UP";
  String d="DOWN";
  String l="LEFT";
  String r="RIGHT";
  Socket sock ;
  var ip=[];
  var name=[];
  DHCP dhcp = DHCP();
  Uri url;
  String status;
  var response;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    printIps();
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        ip.add(addr.address);
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }

  Future<void> initPlatformState() async {
    try {
      dhcp = await WifiAccess.dhcp;
     
    } on PlatformException {}
    if (!mounted) {
      return;
    }
    setState(() {});
  }

 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test The App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("HI"),
                Text("GetWay : ${dhcp.gateway}"),
                Text("Netmask : ${dhcp.netmask}"),
                Text("BroadCast : ${dhcp.broadcast}"),
                SizedBox(
                  height: size.height*0.03,
                ),
               Container(
                 height: size.height*0.07,
                 child: ListView.builder(
                   itemBuilder: (BuildContext context,int index){
                     return Center(child: Text("IP ${index+1} is : ${ip[index]}"));
                   },
                   itemCount: ip.length,
                 ),
               ),
               
                SizedBox(
                  height: size.height * 0.03,
                ),
                // GetIP()
                MaterialButton(
                  child: Text("Connect"),
                  color: Colors.indigo,
                  onPressed: ()async{
                  sock=await Socket.connect('192.168.43.208', 80);
                  print("${sock.address}");
                  print("Connected");
                }),
               Wrap(
                 alignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 20,
                 children: [
                    MaterialButton(
                  child: Text("UP"),
                  color: Colors.lightBlue,
                  onPressed: (){
                    
                 if(sock!=null){
                   sock.write(up);
                 }
                  },
                
                ),
                 MaterialButton(
                  child: Text("DOWN"),
                  color: Colors.red,
                
                  onPressed: () async{
                     if(sock==null){
                    sock=await Socket.connect('192.168.43.208', 80);
                  }
                 if(sock!=null){
                   sock.write("DOWN");
                 }
                  },
                ),
                 MaterialButton(
                  child: Text("LEFT"),
                  color: Colors.green,
                
                  onPressed: () async{
                     if(sock==null){
                    sock=await Socket.connect('192.168.43.208', 80);
                  }
                 if(sock!=null){
                   sock.write("LEFT");
                 }
                  },
                ),
                 MaterialButton(
                  child: Text("RIGHT"),
                  color: Colors.tealAccent,
               
                  onPressed: () async{
                     if(sock==null){
                    sock=await Socket.connect('192.168.43.208', 80);
                  }
                 if(sock!=null){
                   sock.write("RIGHT");
                 }
                  },
                ),
                   MaterialButton(
                  child: Text("STOP"),
                  color: Colors.purple,
               
                  onPressed: () async{
                     if(sock==null){
                    sock=await Socket.connect('192.168.43.208', 80);
                  }
                 if(sock!=null){
                   sock.write("STOP");
                 }
                  },
                ),
                 ],
               ),
                // Container(
                //   height: size.height*0.3,
                //   child: JoystickView(
                //     onDirectionChanged: (a,b){
                //       print("a is $a");
                //       if(a>=350 && a<=75){
                //         //for up direction
                //         if(b==1){
                //           sock.write("UP");
                //         }
                //       }
                //       if(a>=85 && a<=110){
                //         //for right direction
                //         sock.write("RIGHT");
                //       }
                //       if(a>=165 && a<=200){
                //         //for back direction
                //          sock.write("BACK");
                //       }
                //       if(a>=250 && a<=285){
                //         //for left direction
                //         sock.write("LEFT");
                //       }
                //       print("b is $b");
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GetIP() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.08,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: Colors.teal.withOpacity(0.3)),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "http://192.168.43.1:80/ example",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
              hintStyle: TextStyle(fontSize: size.height * 0.026),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: Colors.greenAccent,
            height: size.height * 0.07,
            width: size.width * 0.89,
            child: MaterialButton(
              child: Text(
                "Connect",
                style: TextStyle(fontSize: size.height * 0.027),
              ),
              onPressed:() async{
               
              }
            ),
          ),
        )
      ],
    );
  }
}
