  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:todo_app/Screen/Add%20Todo%20Page.dart';
import 'package:todo_app/Services/Todo%20Services.dart';
class AddTodoList extends StatefulWidget {
  const AddTodoList({super.key});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}
class _AddTodoListState extends State<AddTodoList> {
  bool isloading=true;
  List items=[];
  @override
  void initState() {

    super.initState();
    FetchTodo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text('Todo List')),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 323,
        child: FloatingActionButton.extended(
            onPressed: (){navigatepage();},
            label: Text('Add Todo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
      ),
      body: Visibility(
        visible: isloading,
        child:Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: FetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(child: Text('NO Todo Item',style:Theme.of(context).textTheme.headline3,)),
            child: ListView.builder(
              itemCount: items.length,
                itemBuilder: (context,index){
                final item=items[index]as Map;
                final id=item['_id']as String;
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${index+1}'),),
                        title: Text(item['title'].toString()),
                        subtitle:Text(item['description'].toString()),
                        trailing: PopupMenuButton(
                          onSelected: (value){
                            if(value=='edit'){
                              navigateeditpage(item);
                            }else if(value=='delete'){
                               DeleteById(id);
                            }
                          },
                            itemBuilder: (context){
                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                    child: Text('Edit')),
                                PopupMenuItem(
                                  value: 'delete',
                                    child: Text('Delete')),
                              ];
                            }),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
  Future<void> navigateeditpage(Map item)async{
    final route=MaterialPageRoute(builder: (context)=>AddTodoPage(todo:item));
    await Navigator.push(context, route);
    setState(() {
      isloading=true;
    });
    FetchTodo();
  }
  Future<void >navigatepage()async{
    final route=MaterialPageRoute(builder: (context)=>AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isloading=true;
    });
    FetchTodo();
  }
  Future<void>DeleteById(String id)async{
    final issuccess=await todoservices.DeleteById(id);
    if(issuccess){
      final filteritem=items.where((element) => element['_id']!=id).toList();
      setState(() {
        items=filteritem as List;
      });
    }else{
      // show error message
    }
  }
  Future<void>FetchTodo()async{
    final reponse=await  todoservices.FetchTodo();
    if(reponse!=null){
      setState(() {
        items=reponse;
      });}
    setState(() {
      isloading=false;
    });
  }
}

