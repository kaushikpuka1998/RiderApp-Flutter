import 'dart:async';

import 'package:cloned_uber/AllScreens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloned_uber/AllScreens/LoginScreen.dart';

class spalshscreen extends StatefulWidget {
  static const String idScreen = "splash";
  @override
  _spalshscreenState createState() => _spalshscreenState();
}

class _spalshscreenState extends State<spalshscreen> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:AnimatedSplashScreen(

      splash: Image.asset('images/cyclegif.gif'),

      nextScreen: loginscreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      splashIconSize: 170,


    ),


    );

  }
}
