import 'dart:convert';

import 'package:http/http.dart'as http;
// all api will be here
class todoservices{
  static Future<bool>DeleteById(String id)async {
    final reponse = await http.delete(
        Uri.parse('https://api.nstack.in/v1/todos/$id'));
    return reponse.statusCode==200;
  }
 static Future<List?>FetchTodo()async{
    final reponse=await  http.get(Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'));
    if(reponse.statusCode==200) {
      final data = jsonDecode(reponse.body) as Map;
      final result = data['items'] as List;
      return result;
    }else{
      return null;
    }
    }
}