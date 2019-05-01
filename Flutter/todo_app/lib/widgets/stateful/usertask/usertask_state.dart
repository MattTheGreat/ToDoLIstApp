import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';

class UserTaskStateManager extends State<UserTaskWidget> {
  bool _showDelete = false;
  List<int> _itemsToDelete = new List<int>(); 
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    List<UserTodo> items = widget.tasks;
    appState = StateWidget.of(context).state;
    //addNewTask() {
    //   var newTask = new UserTodo();
    //   newTask.title = "NEW CARD " + items.length.toString();
    //   items.add(newTask);
    //   items = items;
    // }
    Widget getIcon() {
      if(_showDelete){
        return Icon(Icons.delete);
      }
      return Icon(Icons.add);
    }

    Widget getCheckBox(int position) {
      //bool changeVal;
      if(_showDelete) {
        return new Checkbox(
          value: _itemsToDelete.contains(position),
          onChanged: (bool value) {
            setState(() {
              if(value == true)
              {
                _itemsToDelete.add(position);
              } else {
                _itemsToDelete.remove(position);
              }
            });
          }
        );
      }
      return null;
    }

    Widget showCancelButton() {
      if(_showDelete) {
        return             
        FloatingActionButton(
          child:  Icon(Icons.cancel),//Icon(Icons.add),
          onPressed: (){
            setState(() {
              _showDelete = false;
              _itemsToDelete.clear();
            });
          }
        );
      }
      return new Text("");
    }


    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child:  getIcon(),//Icon(Icons.add),
              onPressed: (){
                if(!_showDelete) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return UserTaskForm(task: null);
                    },
                    fullscreenDialog: true,
                  ));
                }
                setState(() {
                  removeRecordsAsync(items, _itemsToDelete, appState);
                  _itemsToDelete.clear();
                  _showDelete = false;
                });
            }),
            showCancelButton()
          ],

        ),
        body : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position){
            return ListTile(
              leading:  getCheckBox(position),
              title: Text(items[position].title.toString()),
              onLongPress: (() => {
                setState(() {
                  _showDelete = true;
                })
              }),
              onTap: () {
                if(!_showDelete) {
                  Navigator.push(
                  context, 
                  MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return UserTaskForm(task: items[position]);                //return UserTaskEdit();
                    },
                    fullscreenDialog: true,
                  ));
                }
              },
            ); 
          }
        ),
      );
  }
}





























