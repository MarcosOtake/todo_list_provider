// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/core/modules/tasks/tasks_module.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/home_week.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/task.dart';

class HomePage extends StatelessWidget {

  HomePage({ Key? key }) : super(key: key);
  void _goToCreateTask(BuildContext context){
Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      animation = CurvedAnimation(parent: animation,curve: Curves.easeInQuad); 
      return ScaleTransition(scale: animation,
      alignment: Alignment.bottomRight,
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
                 // ignore: prefer_const_constructors
                 icon: Icon(TodoListIcons.filter),
                 itemBuilder:(_)=> [
                   // ignore: prefer_const_constructors
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
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                        // ignore: prefer_const_constructors
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