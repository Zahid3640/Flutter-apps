import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';

void main() {
  runApp( XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  void playsound(int soundno) {
    AudioCache().play('audio$soundno.wav');
  }

  Widget buildKey(int soundno, String text,) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 80,
          hoverColor: Colors.blueAccent,
          onPressed: () {
            playsound(soundno);
          },
          child:Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.blue,Colors.cyanAccent,Colors.cyan],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: CustomPaint(
                painter: LinePainter(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 7,
                        ),
                      ),
                    ),
                    Expanded(child: Center(child: Text('$text'))),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 4.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildKey(1, 'Do',),
                buildKey(2, 'Re'),
                buildKey(3, 'Mi'),
                buildKey(4, 'Fa'),
                buildKey(5, 'So'),
                buildKey(6, 'La'),
                buildKey(7, 'Ti'),
              ],
            ),
          ),
        ),

    );
  }
}
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
