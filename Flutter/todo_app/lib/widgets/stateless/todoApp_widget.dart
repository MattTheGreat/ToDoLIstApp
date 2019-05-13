import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/model/app_config.dart';
import 'package:todo_app/model/state.dart';
import 'package:todo_app/services/usertodo_service.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_widget.dart';
import 'package:todo_app/widgets/stateless/login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new TodoAppState();

}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}


const List<Choice> choices = const <Choice>[
  const Choice(title: 'Sign Out', icon: Icons.settings),
  const Choice(title: 'Account', icon: Icons.person)
];

class TodoAppState extends State<TodoApp>{
  StateModel appState;

  callApi(String endpoint) {
    getAllPost(endpoint).then((response){
        print(response);
    }).catchError((error){
      print('error : $error');
    });
  }

  void _select(Choice choice) {
    if(choice.title == 'Sign Out') {
      StateWidget.of(context).signOutWithGoogle().then((onValue) {
        Navigator.of(context).pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
      });
    }
  }

  Widget _buildTodoList(BuildContext context) {
    var config = AppConfig.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        bottom: new PreferredSize(
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(0.2),
          ),
          preferredSize: const Size.fromHeight(20.0),
        ),
        title: Text("Codelife Todo(" + config.environmentName +")",textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            icon: Icon(Icons.settings, color: Colors.black),
            onSelected: _select,
            itemBuilder: (BuildContext context) {
            return choices.map((Choice choise) {
                return PopupMenuItem<Choice>(
                  value:  choise,
                  child: Text(choise.title),
                );
            }).toList();
          },)
        ],
        ),
        body : StreamBuilder(         
           stream:  Firestore.instance.collection(appState.user.email).snapshots(),
           builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);

            }
            if(snapshot.hasError){
                return Text("Error");
            }
             var todoitems = snapshot.data.documents;
             //return new Text(todoitem.data["Title"]);
            return UserTaskWidget(tasks: jsonToUserTodo(todoitems));
           },
        )
        // FutureBuilder<List<UserTodo>>(
        //   //Future builder. Basically calls the getAllPost Method from the usertodo_service 
        //   //which returns a Future. And the results are returned to snapshot of the future builder. 
        //     future: getAllPost(config.apiBaseUrl),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.done) {

        //         if(snapshot.hasError){
        //           return Text("Error");
        //         }
        //         // snapshot.data.forEach((task) => 
        //         //   tasks = tasks + "${task.title}, Description: ${task.description}, Complete: ${task.isComplete} \n"
        //         // );
        //         // return Text('Title from Post JSON : ${snapshot.data.first.title}');
        //         return UserTaskWidget(tasks: snapshot.data);
        //       }
        //       else
        //         return CircularProgressIndicator();
        //     }
        // )
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));

    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}  //   return new MaterialApp(
