import 'package:flutter/material.dart';
import 'package:todo_app/model/usertodo_model.dart';
import 'package:todo_app/widgets/stateful/usertaskform/usertaskform_state.dart';


class UserTaskForm extends StatefulWidget {
  final UserTodo task;

  UserTaskForm({Key key, @required this.task}) : super(key:key);

  @override
    State<StatefulWidget> createState() {
      return UserTaskFormState();
    }
}


