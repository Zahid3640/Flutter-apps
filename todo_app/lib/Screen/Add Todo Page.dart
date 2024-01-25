import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key,this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  bool isedit=false;
  @override
  void initState() {
    super.initState();
    final todo=widget.todo;
    if(widget.todo!=null){
      isedit=true;
      final Title=todo!['title'];
      final Discription=todo!['description'];
      title.text=Title;
      discription.text=Discription;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isedit?'Edit Todo':'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: discription,
              decoration: InputDecoration(
                hintText: 'Discription',),
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              minLines: 5,
            ),
            SizedBox(height: 20,),
            Container(
                height: 40,
                //width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60)
                ),
                child: ElevatedButton(onPressed: isedit?Updatedata:submitdata, child: Text(
                    isedit?'Update':'Submit')))
          ],
        ),
      ),);
  }
  Future<void>Updatedata()async{
    // get data from server
    final todo=widget.todo;
    if(todo==null){
      print('You connot call update without todo data');
      return;
    }
    final id=todo['_id'];
    final iscompleted=todo['is_completed'];
    final Title = title.text;
    final Discription = discription.text;
    final body = {
      "title": Title,
      "description": Discription,
      "is_completed": false,
    };
    // submit update data to server
    final url='https://api.nstack.in/v1/todos/$id';
    final uri=Uri.parse(url);
    final response= await http.put(uri,
        body: jsonEncode(body),
        headers: {'Content-Type':'application/json'}
    );
    if(response.statusCode==200){
      title.text='';
      discription.text='';
      showsuccessmessage('Updation success');
    }else{
      showerrormessage('Updation failed');
    }
  }

  Future<void> submitdata() async {

    // get data from server
    final Title = title.text;
    final Discription = discription.text;
    final body = {
      "title": Title,
      "description": Discription,
      "is_completed": false,
    };

    //submit data to the server
    final url='https://api.nstack.in/v1/todos';
    final uri=Uri.parse(url);
    final response= await http.post(uri,
        body: jsonEncode(body),
         headers: {'Content-Type':'application/json'}
    );
    if(response.statusCode==201){
      title.text='';
      discription.text='';
      showsuccessmessage('creation success');
    }else{
      showerrormessage('Creation failed');
    }
  }
  void showsuccessmessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showerrormessage(String message) {
    final snackBar = SnackBar(content: Text(message,),
    backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  }

