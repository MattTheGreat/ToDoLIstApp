import 'package:flutter/material.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';
import 'package:todo_app/widgets/stateless/login_widget.dart';


class TodoApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new TodoAppState();

}


class TodoAppState extends State<TodoApp>{
  StateModel appState;

  callApi(String endpoint) {
    getAllPost(endpoint).then((response){
        print(response);
    }).catchError((error){
      print('error : $error');
    });
  }


  Widget _buildTodoList(BuildContext context) {
    var config = AppConfig.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Codelife Todo(" + config.environmentName +")"),
        ),
        body : FutureBuilder<List<UserTodo>>(
          //Future builder. Basically calls the getAllPost Method from the usertodo_service 
          //which returns a Future. And the results are returned to snapshot of the future builder. 
            future: getAllPost(config.apiBaseUrl),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }
                // snapshot.data.forEach((task) => 
                //   tasks = tasks + "${task.title}, Description: ${task.description}, Complete: ${task.isComplete} \n"
                // );
                // return Text('Title from Post JSON : ${snapshot.data.first.title}');
                return UserTaskWidget(tasks: snapshot.data);
              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildLoadingIndicator();
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return _buildTodoList(context);
    }
  }
    
  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    //return _buildTodoList(context);
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}  //   return new MaterialApp(
