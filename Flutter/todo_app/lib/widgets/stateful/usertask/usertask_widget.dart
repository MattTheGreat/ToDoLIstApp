import 'package:flutter/material.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/widgets/stateful/usertask/usertask_state.dart';

class UserTaskWidget extends StatefulWidget {
  final List<UserTodo> tasks;

  UserTaskWidget({Key key, @required this.tasks}) : super(key:key);
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return UserTaskStateManager();
    }
}