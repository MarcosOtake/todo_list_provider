
// ignore_for_file: prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/core/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository.dart';
import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service_impl.dart';

class TasksModule extends TodoListModule{
  TasksModule() : super(
    bindings: [
      Provider<TasksRepository>(create: (context) => TasksRepositoryImpl(sqliteConnectionFactory: context.read()),
      ),
      Provider<TasksService>(create: (context) => TasksServiceImpl(tasksRepository: context.read()),
      ),
ChangeNotifierProvider(
  create: (context)=>TaskCreateController(tasksService :context.read()),
  )
    ],
    routers: {
      "/task/create":(context)=>TasksCreatePage(controller: context.read(),),
    }
    );

}