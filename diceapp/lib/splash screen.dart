import 'dart:async';
import 'package:flutter/material.dart';

import 'main.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
            (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return DiceGame();
          }),);
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Image.asset('images/dice.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}

