import 'dart:math';
import 'package:diceapp/splash%20screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    );
  }
}

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  Random random = Random();
  List<int> diceValues = [1, 1, 1, 1];
  List<String> playerNames = ['Player 1', 'Player 2', 'Player 3', 'Player 4'];
  List<int> scores = [0, 0, 0, 0];
  int currentPlayer = 0;

  void rollDice() {
    setState(() {
      diceValues[currentPlayer] = random.nextInt(6) + 1;
      scores[currentPlayer] += diceValues[currentPlayer];
      currentPlayer = (currentPlayer + 1) % 4; // Cycle through players
    });
  }

  void resetGame() {
    setState(() {
      diceValues = [1, 1, 1, 1];
      scores = [0, 0, 0, 0];
      currentPlayer = 0;
    });
  }
  String getWinner() {
    int maxScore = scores.reduce((a, b) => a > b ? a : b);
    int winnerIndex = scores.indexOf(maxScore);
    return playerNames[winnerIndex];
  }


  @override
  Widget build(BuildContext context) {
    final imageAssets = [
      'images/dice1.png',
      'images/dice2.png',
      'images/dice3.png',
      'images/dice4.png',
      'images/dice5.png',
      'images/dice6.png',
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Center(child: Text('Dice App ',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Player: ${playerNames[currentPlayer]}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 2; i++)
                  Column(
                    children: [
                      Text('Player ${i + 1}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                      Dice(value: diceValues[i], imageAssets: imageAssets),
                      Text('Score: ${scores[i]}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow,fontSize: 20),),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 2; i < 4; i++)
                  Column(
                    children: [
                      Text('Player ${i + 1}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                      Dice(value: diceValues[i], imageAssets: imageAssets),
                      Text('Score: ${scores[i]}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow,fontSize: 20),),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
                ElevatedButton(
                  onPressed: rollDice,
                  child: Text('Roll Dice',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                ElevatedButton(
                  onPressed: resetGame,
                  child: Text('Reset Game',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Winner: ${getWinner()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
            Text('Winner Score: ${scores[scores.indexOf(scores.reduce((a, b) => a > b ? a : b))]}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),

          ],
        ),
      ),
    );
  }
}

class Dice extends StatelessWidget {
  final int value;
  final List<String> imageAssets;

  Dice({required this.value, required this.imageAssets});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: Image.asset(
            imageAssets[value - 1], // Value is 1-based, but image list is 0-based
        ),
        );
    }
}