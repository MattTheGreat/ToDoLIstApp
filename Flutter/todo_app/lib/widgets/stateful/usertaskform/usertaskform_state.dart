import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserTaskFormState extends State<UserTaskForm> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  bool _taskcomplete = false;

  saveTask(String endpoint) {
      UserTodo userTaskToSave = new UserTodo(
        title: _titleController.text,
        description: _descriptionController.text,
        createDate: DateTime.now(),
        readDate: null,
        isComplete: false,
        isDeleted: false
        );
      createPost(endpoint, userTaskToSave).then((response){
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
                labelText: "Title:"
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
              });
              })
          ],
        )
    )
  );
  }
}



