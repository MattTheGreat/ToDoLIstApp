import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserTaskFormState extends State<UserTaskForm> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  bool _taskcomplete = false;
  bool _validTitle = false;
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    //return _buildTodoList(context);
    //appState = StateWidget.of(context).state;
    if(widget.task != null && _titleController.text == '') {
      setData(widget.task);
    }
    return _showWidget(context);
  }

  setData(UserTodo task) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;
    _taskcomplete = task.isComplete;
  }

  DateTime getDate() {
    if(widget.task != null) {
      return widget.task.createDate;
    }
    return DateTime.now();
  }


  saveTask(String endpoint) {
      UserTodo userTaskToSave = new UserTodo(
        id: widget.task?.id ?? null,
        title: _titleController.text,
        description: _descriptionController.text,
        createDate: getDate(),
        readDate: null,
        isComplete: _taskcomplete,
        isDeleted: false
        );

      if(userTaskToSave.title != null && userTaskToSave.title.isNotEmpty) {
        _validTitle = false;
        createRecordasync(userTaskToSave, appState).then((response){
          //Navigator.pushAndRemoveUntil("/");
          Navigator.of(context).pop();
          //print("response: $response");
        }).catchError((error){
          print("error: $error");
        });
      }
      else {
        _validTitle = true;
      }
      //createPost(endpoint, userTaskToSave).then((response){
      //  print(response);
      //}).catchError((error){
      //  print('error : $error');
      //});
  }

  Widget _showWidget(BuildContext context) {
    var config = AppConfig.of(context);
    appState = StateWidget.of(context).state;

    return Scaffold(
      appBar: AppBar(
      title: Text(_titleController.text)), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          Fluttertoast.showToast(msg: "Saving Task");
          saveTask(config.apiBaseUrl);
          //Navigator.pop(context);
        },
      ),
      body: Form(
      key: _formkey,
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title:",
                errorText: _validTitle ? 'A title is required' : null,
                errorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.red) )
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description:"
              ),
            ),
            CheckboxListTile(
              title: new Text("Complete"),
              value: _taskcomplete,
              onChanged: (bool value) {
                setState(() {
                 _taskcomplete = value; 
                 print(value);                
              });
              })
          ],
        )
    )
  );
  }
}



