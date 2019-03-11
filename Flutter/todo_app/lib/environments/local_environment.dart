import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/app_config.dart';


String getUri()  {
  if(Platform.isAndroid) {
    return "10.0.2.2:5001";
  }
  if(Platform.isIOS) {
    return "localhost:5001";
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









