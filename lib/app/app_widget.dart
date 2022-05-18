// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/modules/tasks/tasks_module.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/core/splash/splash_page.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_module.dart';
import 'package:todo_list_provider/app/modules/auth/login/auth_module.dart';
import 'core/ui/todo_list_ui_config.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();
  @override
  void initState() {
   // FirebaseAuth auth = FirebaseAuth.instance;
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List Provider",
      theme: TodoListUiConfig.theme,
      navigatorKey: TodoListNavigator.navigatorKey,
      // ignore: prefer_const_literals_to_create_immutables
      //localizationsDelegates: [
       // GlobalMaterialLocalizations.delegate,
        //GlobalWidgetsLocalizations.delegate,

     // ],
      // ignore: prefer_const_literals_to_create_immutables
     // supportedLocales: [
      //  Locale("pt","BR"),
      //],
      
      
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
