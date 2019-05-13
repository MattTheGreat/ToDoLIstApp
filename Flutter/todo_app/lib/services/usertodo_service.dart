import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/model/state.dart';
import 'dart:async';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:uuid/uuid.dart';
//String _sumuri = "10.0.2.2:5001"; //This is the alias back to your machine localhost for a emulated device.
//String _sumUrl = 'localhost:5001';// Good for web dev, bad for android :(
String kpath = "/api/todotask";
// Uri getUri()  {
//   if(Platform.isAndroid) {
//     return new Uri.http("10.0.2.2:5001", '/api/todotask');
//   }
//   return new Uri.http("localhost:5001", '/api/todotask');
// }

Future<http.Response> createPost(String endpoint, UserTodo postData) async {
  try  {
    final response = await http.post(new Uri.http(endpoint, kpath),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: postToJson(postData)
    );
    return response;
  } catch (e) {
    print(e.toString());
    throw new Exception(e.toString());
  }
}


Future<List<UserTodo>> getAllPost(String endpoint) async {
  try  {
    final response = await http.get(new Uri.http(endpoint, kpath));
    //print(response.body);
    return allPostsFromJson(response.body);
  } catch (e) {
    print(e.toString());
    throw new Exception(e.toString());
  }
}


List<UserTodo> jsonToUserTodo(List<DocumentSnapshot> snapshot){
    return allQueriesToModel(snapshot);
}

Future<void> createRecordasync(UserTodo todo, StateModel state) async {
  String id = todo.id;
  if(todo.id == null) {
    id = todo.createDate.toString() + new Uuid().v1();
  }
  Firestore.instance.collection(state.user.email).document(id).setData({
      "Id": id,
      "Title": todo.title,
      "Description": todo.description,
      "CreateDate": todo.createDate,
      "ReadDate": todo.readDate,
      "IsComplete": todo.isComplete,
      "IsDeleted": todo.isDeleted
  });
}
Future<void> removeRecordsAsync(List<UserTodo> todos, List<int> positions, StateModel state) {
  for(var a in positions) {
    Firestore.instance.collection(state.user.email).document(todos[a].id).delete();
  }
  return null;
}



