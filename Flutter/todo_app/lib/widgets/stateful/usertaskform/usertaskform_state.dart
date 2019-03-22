import 'package:flutter/material.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserTaskFormState extends State<UserTaskForm> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  bool _taskcomplete = false;

  saveTask() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(_titleController.text)), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          Fluttertoast.showToast(msg: "Saving Task");
          saveTask();
          Navigator.pop(context);
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



