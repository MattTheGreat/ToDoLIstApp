import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserTaskFormState extends State<UserTaskForm>  {

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
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.purple,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: new PreferredSize(
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(0.2),
          ),
          preferredSize: const Size.fromHeight(20.0),
        ),
        centerTitle: true,
        title: Text(_titleController.text, textAlign: TextAlign.start, style: TextStyle(fontSize: 25),),
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        textTheme: TextTheme(title: TextStyle(color: Colors.black, fontWeight: FontWeight.bold )),
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Fluttertoast.showToast(msg: "Saving Task");
          saveTask(config.apiBaseUrl);
          //Navigator.pop(context);
        },
      ),
      body: Form(
        key: _formkey,
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          child: new Center(
            child: new Column(         
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                maxLength: 35,
                controller: _titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  labelText: "Title:",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide()
                  ),
                  errorText: _validTitle ? 'A title is required' : null,
                  errorBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.red) )
                ),
              ),              
              new Padding(
                padding: EdgeInsets.only(top: 40.0),
              ),
              Container(
                height: 260.0,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 99,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(fontSize: 18),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide()
                    ),

                  ),
                )
              ),
              new Padding(
                padding: EdgeInsets.only(top: 40.0),
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
      )
    )
  );
  }
}



