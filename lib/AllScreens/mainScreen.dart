import 'package:flutter/material.dart';

class mainscreen extends StatefulWidget {

  static const String idScreen = "mainscreen";
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cycle Ride",),

      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Image(image: AssetImage("images/cyclenew.jpg"),)
        ],
      ),
    );
  }
}
