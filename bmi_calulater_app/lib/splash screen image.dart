import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'input page.dart';

class splashscreen extends StatefulWidget {  @override
State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 7),
          () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) {
          return InputPage();
        },));
      },
    );



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Center(
              child: Image.asset('asset/bmi.png'))),
    );
  }}
