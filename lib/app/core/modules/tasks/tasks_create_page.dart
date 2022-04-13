import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/modules/tasks/task_create_controller.dart';

class TasksCreatePage extends StatelessWidget {
TaskCreateController _controller;
 TasksCreatePage({ Key? key ,required TaskCreateController controller}) :
  _controller = controller,
   super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}