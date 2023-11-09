import 'package:flutter/material.dart';
import 'package:quiz_apps/Screens/result%20screen.dart';
import 'dart:async';

import '../Widget/answer card.dart';
import '../Widget/next button.dart';

// Define your Question model here.
class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question(this.question, this.options, this.correctAnswerIndex);
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  int timerSeconds = 10;
  Timer? _timer;

  // List of questions
  List<Question> questions = [
    Question('1. What is the capital of France?', ['a) Madrid', 'b) Paris', 'c) Berlin', 'd) Rome',], 1),
    Question('2. In what continent is Brazil located?', [  'a) Europe', 'b) Asia', 'c) North America', 'd) South America',], 3),
    Question('3. What is the largest planet in our solar system?', [ 'a) Earth', 'b) Jupiter', 'c) Saturn', 'd) Venus',], 1),
    Question('4. What is the longest river in the world?', [  'a) Nile', 'b) Amazon', 'c) Mississippi', 'd) Danube',], 0),
    Question('5. Who is the main character in the Harry Potter series?', ['a) Hermione Granger', 'b) Ron Weasley', 'c) Harry Potter', 'd) Neville Longbottom',], 2),
    Question( '6. What is the smallest planet in our solar system?', [ 'a) Venus', 'b) Mars', 'c) Earth', 'd) Mercury',], 3),
    Question('7. Who wrote the play Romeo and Juliet?', ['a) William Shakespeare', 'b) Oscar Wilde', 'c) Jane Austen', 'd) Charles Dickens',], 0),
    Question('8. What is the highest mountain in the world?', ['a) Mont Blanc', 'b) Everest', 'c) Kilimanjaro', 'd) Aconcagua',], 1),
    Question('9. What is the name of the famous painting by Leonardo da Vinci that depicts a woman?', ['a) Starry Night', 'b) The Persistence of Memory', 'c) The Last Supper', 'd) Mona Lisa',], 3)


    // Add more questions here
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        timer.cancel();
        goToNextQuestion();
      }
    });
  }

  void pickAnswer(int value) {
    if (_timer != null) {
      _timer?.cancel();
    }
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
      timerSeconds = 10;
      startTimer();
    } else {
      _timer?.cancel();
      // Here, you can navigate to a result screen or perform any other action
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(child: Text('Quiz App', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Time Remaining: $timerSeconds seconds',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                question.question,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Column(
                children: question.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return GestureDetector(
                    onTap: selectedAnswerIndex == null ? () => pickAnswer(index) : null,
                    child: AnswerCard(
                      currentIndex: index,
                      question: option,
                      isSelected: selectedAnswerIndex == index,
                      selectedAnswerIndex: selectedAnswerIndex,
                      correctAnswerIndex: question.correctAnswerIndex,
                    ),
                  );
                }).toList(),
              ),
              if (questionIndex == questions.length - 1)
                RectangularButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(
                          score: score,
                        ),
                      ),
                    );
                  },
                  label: 'Finish',
                )
              else
                RectangularButton(
                  onPressed: selectedAnswerIndex != null ? goToNextQuestion : null,
                  label: 'Next',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
