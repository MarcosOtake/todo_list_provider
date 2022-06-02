// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/task.dart';
import 'package:todo_list_provider/app/modules/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/task_model.dart';

import 'home_controller.dart';

class HomeTasks extends StatelessWidget {

  const HomeTasks({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Expanded(
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(
               height: 20,
             ),
             Selector<HomeController,String>( selector: (context,controller){
               
               return controller.filterSelected.description;
             },
             builder: (context,value,child){
              return Text("TASKS $value",
             style:context.titleStyle ,
             );
             },
             
             ),
             
             Column(
               
               children: context.select<HomeController,List<TaskModel>>(
                 (controller) =>controller.filteredTasks )
                 .map((t) => Task(model: t)).toList(),
             ) 
                 
                 
               ],
             ),
           
         );
  }
}