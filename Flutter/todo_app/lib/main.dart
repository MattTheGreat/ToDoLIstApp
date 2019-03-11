import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';

// void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: TodoApp()
    );
  }
}

  // This widget is the root of your application.
class TodoApp extends StatelessWidget{

  callApi(String endpoint) {
    getAllPost(endpoint).then((response){
        print(response);
    }).catchError((error){
      print('error : $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Codelife Todo(" + config.environmentName +")"),
        ),
        body : FutureBuilder<List<UserTodo>>(
            future: getAllPost(config.apiBaseUrl),
            builder: (context, snapshot) {
              callApi(config.apiBaseUrl);
              if(snapshot.connectionState == ConnectionState.done) {
                // String tasks = "${config.appName}";
                if(snapshot.hasError){
                  return Text("Error");
                }
                // snapshot.data.forEach((task) => 
                //   tasks = tasks + "${task.title}, Description: ${task.description}, Complete: ${task.isComplete} \n"
                // );
                // return Text('Title from Post JSON : ${snapshot.data.first.title}');
                //this needs to return the stateful widget not a text
                return UserTaskWidget(tasks: snapshot.data);
              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }

}  //   return new MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: new ThemeData(
  //       // This is the theme of your application.
  //       //
  //       // Try running your application with "flutter run". You'll see the
  //       // application has a blue toolbar. Then, without quitting the app, try
  //       // changing the primarySwatch below to Colors.green and then invoke
  //       // "hot reload" (press "r" in the console where you ran "flutter run",
  //       // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
  //       // counter didn't reset back to zero; the application is not restarted.
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: new MyHomePage(title: 'Flutter Demo Home Page'),
  //   );
  // }

