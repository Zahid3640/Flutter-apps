import 'dart:async';

import 'package:counter_app/HomePage.dart';
import 'package:flutter/material.dart';
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
      return homepage();
    }),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(child: Text('Welcome to ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33,color: Colors.green),)),
           SizedBox(height: 40,),
           Center(
             child: Container(
                 height: 200,
                 width: 200,
                 child: Image.asset('lib/image/counter.png')),
           ),
           SizedBox(height:70,),
           Center(child: Text('App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70,color: Colors.red),)),
         ],
      )
    );
  }
}
