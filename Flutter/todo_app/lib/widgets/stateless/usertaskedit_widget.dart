import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserTaskEdit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"))
        , 
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
          },
        ),
        body : Container(
        color: Colors.white,
        child: Text("under construction"),
        //child: Text("Inside Edit Widget"),
      ),
      
      );
  }
}






























