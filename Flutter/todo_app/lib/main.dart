import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';

// void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Home()
    );
  }
}

  // callApi() {
  //   getAllPost().then((response){
  //       print(response);
  //   }).catchError((error){
  //     print('error : $error');
  //   });
  // }

  // This widget is the root of your application.
class Home extends StatelessWidget{

  callApi(Uri endpoint) {
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
      appBar: AppBar(),
        body : FutureBuilder<List<UserTodo>>(
            future: getAllPost(config.apiBaseUrl),
            builder: (context, snapshot) {
              callApi(config.apiBaseUrl);
              if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }

                // return Text('Title from Post JSON : ${snapshot.data.first.title}');
                return Text('Title: ${config.appName}, Description: ${snapshot.data.first.description}, Complete: ${snapshot.data.first.isComplete}');

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

