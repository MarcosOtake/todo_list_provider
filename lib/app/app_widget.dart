// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/splash/splash_page.dart';
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
    //FirebaseAuth auth = FirebaseAuth.instance;
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
      theme: TodoListUiConfig.theme,
      title: 'Todo List Provider',
      initialRoute: "/login",
      routes: {
        ...AuthModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
