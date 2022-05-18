// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/modules/tasks/tasks_module.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_drawer.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_filters.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_header.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_tasks.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_week.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/task.dart';

class HomePage extends StatefulWidget {
final  HomeController _homeController;

  HomePage({ Key? key,required HomeController homeController }) :
  _homeController = homeController,
   super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
void initState(){
  super.initState();
  widget._homeController.loadTotalTasks();
}


  void _goToCreateTask(BuildContext context){
Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      animation = CurvedAnimation(parent: animation,curve: Curves.easeInQuad); 
      return ScaleTransition(scale: animation,
      alignment: Alignment.bottomRight,
      child: child,
      );
      },
    
  
  pageBuilder:(context, animation, secondaryAnimation) {
      return TasksModule().getPage("/task/create", context);
    },
  ),
  );
  
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
             iconTheme: IconThemeData(color: context.primaryColor),
             backgroundColor:Color(0xFFFAFBFE),
             elevation: 0,
             actions: [
               PopupMenuButton(
                 
                 icon: Icon(TodoListIcons.filter),
                 itemBuilder:(_)=> [
                
                   PopupMenuItem<bool>(child: Text("Mostrar tarefas concluidas"))

                 ],
                 )
             ],
             ),
             floatingActionButton: FloatingActionButton(
               backgroundColor: context.primaryColor,
               onPressed:()=>_goToCreateTask(context) ,
               child: Icon(Icons.add),),
             backgroundColor: Color(0xFFFAFBFE),
           drawer: HomeDrawer(),
           body: LayoutBuilder( 
             builder: (context, constraints) {
               return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth
                    ),
                    child: Container(
                      margin:EdgeInsets.symmetric(horizontal: 20),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       
                        children: [
                        
                        HomeHeader(),
                        HomeFilters(),
                         HomeWeek(),
                         HomeTasks(),
                         Task(),
                      ],)),
                    )
                    ), 
               );
             }
           ),      
       );
  }
}