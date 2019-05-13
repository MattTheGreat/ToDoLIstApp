import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

UserTodo postFromJson(String str) {
  final jsonData = json.decode(str);
  return UserTodo.fromJson(jsonData);
}

String postToJson(UserTodo data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

DateTime timeStampToDateTime(Timestamp ts) {
  if(ts != null) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch); 
  }
  return null;
}

List<UserTodo> allPostsFromJson(String str) {
  final jsonData = json.decode(str).cast<Map<String, dynamic>>();
  //return new List<UserTodo>.from(jsonData.map((x) => UserTodo.fromJson(x)));
  //return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  return jsonData.map<UserTodo>((json) => UserTodo.fromJson(json)).toList();
}

List<UserTodo> allQueriesToModel(List<DocumentSnapshot> snapshot){
  return snapshot.map<UserTodo>((snap) => UserTodo.fromQuery(snap)).toList();
}

class UserTodo {
  final String id;
  final String title;
  final String description;
  final DateTime createDate;
  final DateTime readDate;
  final bool isComplete;
  final bool isDeleted;

  const UserTodo({
    Key key,
    this.id,
    this.title,
    this.description,
    this.createDate,
    this.readDate,
    this.isComplete,
    this.isDeleted
  });

  factory UserTodo.fromJson(Map<String, dynamic> parsedJson) => UserTodo(
      id: parsedJson['Id'],
      title: parsedJson['Title'],
      description: parsedJson['Description'],
      createDate: DateTime.parse(parsedJson['CreateDate']),
      readDate: DateTime.parse(parsedJson['ReadDate']),
      isComplete: parsedJson['IsComplete'] as bool,
      isDeleted: parsedJson['IsDeleted'] as bool
  );


  factory UserTodo.fromQuery(DocumentSnapshot snap) => UserTodo(
      id: snap['Id'],
      title: snap['Title'],
      description: snap['Description'],
      createDate: timeStampToDateTime(snap['CreateDate']), //DateTime.fromMicrosecondsSinceEpoch(snap['CreateDate'].microsecondsSinceEpoch),
      readDate:  timeStampToDateTime(snap['ReadDate']), //DateTime.fromMicrosecondsSinceEpoch(.microsecondsSinceEpoch),
      isComplete: snap['IsComplete'] as bool,
      isDeleted: snap['IsDeleted'] as bool
  );


  Map<String, dynamic> toJson() => {
      "id": id,
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
