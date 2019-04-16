import 'package:flutter/material.dart';
import 'package:todo_app/widgets/stateless/login_widget.dart';
import 'package:todo_app/widgets/stateless/todoApp_widget.dart';

class TodoRoutes extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo",
      // initialRoute: '/login',
      routes: {
        '/': (context) => TodoApp(),
        '/login': (context) => LoginScreen(),
        '/Home': (context) => TodoApp()
      },
    );
  }
}


















