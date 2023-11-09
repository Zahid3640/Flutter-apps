import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_apps/Screens/quiz%20screen.dart';
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
            return QuizScreen();
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
              child: Image.asset('assets/quiz.png'),
            ),
          ),
        ],
      ),
    );
  }
}

