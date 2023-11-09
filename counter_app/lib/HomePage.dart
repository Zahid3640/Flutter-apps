import 'package:flutter/material.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();

}

class _homepageState extends State<homepage> {
  int count=0;

  void _increment(){
    setState(() {
      count++;
    });
  }
  void _decrement(){
    if(count<1){
      return;
    }
    setState(() {
      count--;
    });
  }
  void _reset() {
    setState(() {
      count = 0;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Counter App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$count",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
          SizedBox(height: 80,),
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(45),
                  child: FloatingActionButton(
                      onPressed:_decrement,
                      child: Icon(Icons.remove,),
                  ),
                ),
                SizedBox(width: 150,),
                FloatingActionButton(
                    onPressed: _increment,
                child: Icon(Icons.add),),
              ],
            ),
          ),
          SizedBox(height: 80,),
          FloatingActionButton(onPressed: _reset,
          child: Text("Reset",style: TextStyle(fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}

