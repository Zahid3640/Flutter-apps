import 'package:flutter/material.dart';
import 'package:quiz_apps/Screens/quiz%20screen.dart';
import 'package:quiz_apps/Widget/next%20button.dart';
import 'package:quiz_apps/Screens/quiz screen.dart';

import '../models/questions.dart';
/*
import '/models/questions.dart';
import '/screen/quiz_screen.dart';
import '/widgets/next_button.dart';*/

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 1000),
          const Text(
            'Your Score',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 9,
                  color: Colors.green,
                  backgroundColor: Colors.red,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(score / questions.length * 100).round()}%',
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          RectangularButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>QuizScreen()));
          }, label: 'Restart')
        ],
      ),
    );
  }
}