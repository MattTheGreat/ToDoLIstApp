import 'dart:convert';

UserTodo postFromJson(String str) {
  final jsonData = json.decode(str);
  return UserTodo.fromJson(jsonData);
}

List<UserTodo> allPostsFromJson(String str) {
  final jsonData = json.decode(str).cast<Map<String, dynamic>>();
  //return new List<UserTodo>.from(jsonData.map((x) => UserTodo.fromJson(x)));
  //return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  return jsonData.map<UserTodo>((json) => UserTodo.fromJson(json)).toList();
}

class UserTodo {
  String title;
  String description;
  DateTime createDate;
  DateTime readDate;
  bool isComplete;
  bool isDeleted;

  UserTodo({
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
      "createDate": createDate,
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
