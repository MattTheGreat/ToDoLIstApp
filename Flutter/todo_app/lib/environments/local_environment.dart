import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/app_config.dart';


Uri getUri()  {
  if(Platform.isAndroid) {
    return new Uri.http("10.0.2.2:5001", '/api/todotask');
  }
  if(Platform.isIOS) {
    return new Uri.http("localhost:5001", '/api/todotask');
  }
  return null;
}

void main() {

  var configuredApp = new AppConfig(
    appName: 'Todo App',
    environmentName: 'local',
    apiBaseUrl: getUri(),
    child: new MyApp()
  );

  runApp(configuredApp);
}









