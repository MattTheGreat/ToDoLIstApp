import 'package:flutter/material.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';

class UserTaskStateManager extends State<UserTaskWidget> {

  @override
  Widget build(BuildContext context) {
    List<UserTodo> items = widget.tasks;

    //addNewTask() {
    //   var newTask = new UserTodo();
    //   newTask.title = "NEW CARD " + items.length.toString();
    //   items.add(newTask);
    //   items = items;
    // }


    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return UserTaskForm(task: null);
                //return UserTaskEdit();
              },
              fullscreenDialog: true,
            ));
            // setState(() {
            //   addNewTask();
            // });
          },
        ),
        body : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position){
            return ListTile(
              title: Text(items[position].title.toString()),
              onTap: (() => {
                Navigator.push(
                context, 
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return UserTaskForm(task: items[position]);
                //return UserTaskEdit();
                  },
                  fullscreenDialog: true,
                ))
              }),
            ); 
          }
        ),
      );
  }
}






























