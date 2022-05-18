import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository.dart';
import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service_impl.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_page.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_controller.dart';

class HomeModule extends TodoListModule{
  HomeModule(): super(
    bindings: [
       Provider<TasksRepository>(create: (context) => TasksRepositoryImpl(sqliteConnectionFactory: context.read()),
      ),
      Provider<TasksService>(create: (context) => TasksServiceImpl(tasksRepository: context.read()),
      ),

      ChangeNotifierProvider(
        create: (context)=> HomeController(tasksService: context.read()),
      ),
    ],
    routers: {
      // ignore: prefer_const_constructors
      '/home':(context) =>  HomePage(homeController: context.read(),),
          }
  );

}