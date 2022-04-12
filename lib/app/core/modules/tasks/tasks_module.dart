
// ignore_for_file: prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/core/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';

class TasksModule extends TodoListModule{
  TasksModule() : super(
    bindings: [
ChangeNotifierProvider(
  create: (context)=>TaskCreateController(),
  )
    ],
    routers: {
      "/task/create":(context)=>TasksCreatePage(controller: context.read(),),
    }
    );

}