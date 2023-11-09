import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(TasbeehApp());

}

class TasbeehApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
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
            return TasbeehScreen();
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
              child: Image.asset('assets/tasbeeh.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}


class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  final List<Tasbeeh> tasbeehList = [
    Tasbeeh(name: 'SubhanAllah'),
    Tasbeeh(name: 'La ilaha illallah'),
    Tasbeeh(name: 'AllahuAkbar'),
    Tasbeeh(name: 'Alhamdulillah'),
    Tasbeeh(name: ' Ala Muhammad'),
    Tasbeeh(name: 'Bismillah'),
    Tasbeeh(name: 'Allah'),
    Tasbeeh(name: 'Ayate Karima'),
    Tasbeeh(name: 'Subhana rabbika rab..'),
    Tasbeeh(name: 'Astagfar-Allah'),

  ];

  TextEditingController newTasbeehNameController = TextEditingController();

  void addNewTasbeeh(String name) {
    if (name.isNotEmpty) {
      setState(() {
        tasbeehList.add(Tasbeeh(name: name));
        newTasbeehNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Tasbeeh '),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/tasbeeh4.jpg', // Change this to your desired background image asset
            fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity
          ),
          ListView.builder(
            itemCount: tasbeehList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue, // Change the color to green
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tasbeehList[index].name,
                          style: TextStyle(color: Colors.black, fontSize: 20), // Change text color to black
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Count: 0 (0)',
                              ),
                              TextSpan(
                                text: '\nTotal count: 0',
                                style: TextStyle(
                                  fontSize: 10, // Change the font size for Total count
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TasbeehCounterScreen(
                            tasbeeh: tasbeehList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Container(
                          height: 325,
                          width: 600,
                          child: AlertDialog(
                            title: Text('Enter New Tasbeeh Name'),
                            content: Column(
                              children: [
                                TextFormField(

                                  controller: newTasbeehNameController,
                                  decoration: InputDecoration(labelText: "Tasbeeh Name"),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(labelText: "Tasbeeh Set"),
                                  keyboardType: TextInputType.number ,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      addNewTasbeeh(newTasbeehNameController.text);
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ),
                    );
                  },
                );
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class Tasbeeh {
  final String name;
  int count = 0;

  Tasbeeh({required this.name});
}

class TasbeehCounterScreen extends StatefulWidget {
  final Tasbeeh tasbeeh;

  TasbeehCounterScreen({required this.tasbeeh});

  @override
  _TasbeehCounterScreenState createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> {
  int count = 0;
  int increment=0;
  int setsCompleted = 0;

  void incrementCount() {
    setState(() {
      increment++;
      if (count < 33) {
        count++;
        //setsCompleted++;
      }
      else{
        count = 0;
        setsCompleted++;// Reset count to 0 when it reaches 33
      }
    });
  }

  void resetCount() {
    setState(() {
      count = 0;
      increment=0;
      setsCompleted=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Tasbeeh Counter'),
              GestureDetector(
                onTap: resetCount,
                  child: Icon(Icons.refresh)),
            ],
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
            children: [
             Image.asset(
                'assets/tasbeeh4.jpg',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Text(
                      '${widget.tasbeeh.name}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 60),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: GestureDetector(
                            onTap: incrementCount,
                            child: CircularProgressIndicator(
                              strokeWidth: 12,
                              value:  count/ 33,
                              color: Colors.green,
                              backgroundColor: Colors.red,

                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              count.toString(),
                              style: const TextStyle(fontSize: 60,color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Set Completed:',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text(
                              setsCompleted.toString(),
                              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ],
                        ),
                        Text('Commulative:$increment',style: const TextStyle(fontSize: 20,color: Colors.white),)
                      ],
                    )
                  ],
                ),
              ),
            ],
            ),
        );
    }
}