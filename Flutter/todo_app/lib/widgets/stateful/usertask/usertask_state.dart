import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';

class UserTaskStateManager extends State<UserTaskWidget> with TickerProviderStateMixin{
  bool _showDelete = false;
  List<int> _itemsToDelete = new List<int>(); 
  StateModel appState;
  Animation animation;
  AnimationController animationController;
  AnimationController _fanimationController;
  Animation<Offset> _cancelSlide;
  Animation<Offset> _deleteSlide;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500), vsync: this
    );
    _fanimationController = AnimationController(
      duration: Duration(milliseconds: 300), vsync: this
    );

    // animation = Tween(begin: 0.0, end: 500.0).animate(animationController)
    //     ..addListener(() {
    //       setState(() {
            
    //       });
    //     });
    _cancelSlide = Tween<Offset>(end: Offset.zero, begin: Offset(2.0, 0.0)).animate(animationController);
    _deleteSlide = Tween<Offset>(end: Offset(-0.2, 0.0), begin: Offset(1.0,0.0)).animate(_fanimationController);
    //animationController.forward();
  }

  @override
  void dispose(){
    animationController.dispose();
    _fanimationController.dispose();
    super.dispose();
  }

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

    Widget showComplete(bool isComplete) {
      if(isComplete) {
        return Column(children: <Widget>[
          Text("Done"),
          Icon(Icons.done, color: Colors.green,),
        ],); 
      }
      return Icon(Icons.warning, color: Colors.yellow,);
    }

    Widget showCancelButton() {
      if(_showDelete) {
      _fanimationController.forward();
        animationController.forward();          
      } else {
      animationController.reverse();
      _fanimationController.reverse();
      }
      return Container (
      // height: animation.value,
      // width: animation.value,
      child: SlideTransition( 
        child: FloatingActionButton(
          heroTag: "btnClear",
          child:  Icon(Icons.cancel),
          onPressed: (){
            setState(() {
              _showDelete = false;
              _itemsToDelete.clear();
            });
        }),
        position: _cancelSlide,
        )
      ); 
    }

    Color turnRedIfDelete() {
      if(_showDelete) {
        return Colors.red;
      }
      return Colors.deepPurple;
    }


    return Scaffold(
      backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SlideTransition( 
              child: FloatingActionButton(
                heroTag: "btnDelete",
                backgroundColor: turnRedIfDelete(),
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
                } else {
                  setState(() {
                    removeRecordsAsync(items, _itemsToDelete, appState);
                    _itemsToDelete.clear();
                    _showDelete = false;
                    Fluttertoast.showToast(msg: "Task Deleted");
                  });
                }
            }),
            position: _deleteSlide,
            ),
            showCancelButton()
          ],

        ),
        body : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position){
            return ListTile(
              leading:  getCheckBox(position),
              trailing: showComplete(items[position].isComplete),
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





























