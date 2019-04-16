import 'dart:convert';

import 'package:flutter/material.dart';

UserTodo postFromJson(String str) {
  final jsonData = json.decode(str);
  return UserTodo.fromJson(jsonData);
}

String postToJson(UserTodo data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

List<UserTodo> allPostsFromJson(String str) {
  final jsonData = json.decode(str).cast<Map<String, dynamic>>();
  //return new List<UserTodo>.from(jsonData.map((x) => UserTodo.fromJson(x)));
  //return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  return jsonData.map<UserTodo>((json) => UserTodo.fromJson(json)).toList();
}

class UserTodo {
  final String title;
  final String description;
  final DateTime createDate;
  final DateTime readDate;
  final bool isComplete;
  final bool isDeleted;

  const UserTodo({
    Key key,
    this.title,
    this.description,
    this.createDate,
    this.readDate,
    this.isComplete,
    this.isDeleted
  });

  factory UserTodo.fromJson(Map<String, dynamic> parsedJson) => UserTodo(
      title: parsedJson['Title'],
      description: parsedJson['Description'],
      createDate: DateTime.parse(parsedJson['CreateDate']),
      readDate: DateTime.parse(parsedJson['ReadDate']),
      isComplete: parsedJson['IsComplete'] as bool,
      isDeleted: parsedJson['IsDeleted'] as bool
  );

  Map<String, dynamic> toJson() => {
      "title": title,
      "description": description,
      "createDate": createDate.toString(),
      "readDate": readDate,
      "isComplete": isComplete,
      "isDeleted": isDeleted
  };

  // factory UserTodo.fromJson(Map<String, dynamic> parsedJson) {
  //   return UserTodo(
  //     title: parsedJson['title'],
  //     description: parsedJson['description'],
  //     createDate: parsedJson['createDate'],
  //     readDate: parsedJson['readDate'],
  //     isComplete: parsedJson['isComplete'],
  //     isDeleted: parsedJson['isDeleted']
  //   );
  // }
    
}
