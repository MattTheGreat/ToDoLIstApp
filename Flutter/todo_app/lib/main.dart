import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart/todo_routes.dart';
import 'package:todo_app/state_widget.dart';

//void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//         home: TodoRoutes()
//     );
//   }
// }

// - StateWidget incl. state data
//    - RecipesApp
//        - All other widgets which are able to access the data
void main() => runApp(new StateWidget(
       child: new TodoRoutes(),
     ));


// class MyApp extends State<StateWidget> {
//   @override
//   Widget build(BuildContext context){
//     return StateWidget(child: new TodoRoutes(),);
//   }
// }
  // This widget is the root of your application.
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

