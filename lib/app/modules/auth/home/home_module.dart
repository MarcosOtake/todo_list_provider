import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_page.dart';

class HomeModule extends TodoListModule{
  HomeModule(): super(
    //bindings: null,
    routers: {
      // ignore: prefer_const_constructors
      '/home':(context) =>  HomePage(),
          }
  );

}