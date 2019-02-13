
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:todo_app/model/usertodo_model.dart';

//String _sumuri = "10.0.2.2:5001"; //This is the alias back to your machine localhost for a emulated device.
//String _sumUrl = 'localhost:5001';// Good for web dev, bad for android :(


Uri getUri()  {
  if(Platform.isAndroid) {
    return new Uri.http("10.0.2.2:5001", '/api/todotask');
  }
  return new Uri.http("localhost:5001", '/api/todotask');
}

Future<List<UserTodo>> getAllPost() async {
  try  {
    var localuri = getUri(); //get the uri based on device
    final response = await http.get(localuri);
    print(response.body);
    return allPostsFromJson(response.body);

  } catch (e) {
    print(e.toString());
    throw new Exception(e.toString());
  }
}
