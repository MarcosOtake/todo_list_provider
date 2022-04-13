import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widget/todo_listlogo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
    
      // ignore: prefer_const_constructors
      body:  Center(
       // ignore: prefer_const_constructors
       child: TodoListlogo(),
          
        ),
      
    );
  }
}
