
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget{
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;
  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    required this.selected,
     this.totalTasksModel}) : super(key: key);

     double _getPercentFinish(){
       final total = totalTasksModel?.totalTasks ?? 0.0;
       final totalFinish = totalTasksModel?.totalTasksFinish ?? 0.1;
    if(total==0){
    return 0.0;
}
    final percent = (totalFinish * 100)/ total;
    return percent / 100 ;
     }

 



  @override
  Widget build(BuildContext context) {
    return Container(
      
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected? context.primaryColor:Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(.4)
        ),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("${totalTasksModel?.totalTasks ?? 0 } TASKS",
        style: context.titleStyle.copyWith(fontSize: 10,
        color :selected? Colors.white : Colors.grey,
        ),),
        Text(
          label,
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: selected ?Colors.white : Colors.black,

        ),),
       TweenAnimationBuilder<double>(
         tween: Tween(begin: 0.0,end: _getPercentFinish()),
       duration: Duration(seconds: 1),
       builder:(context ,value, child) {
           return LinearProgressIndicator(
            backgroundColor: selected ?context.primaryColorLight : Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(
              selected ? Colors.white : context.primaryColor),
            value:value,
          );
       },
           
       )
        ],
        
          ),

      );
    
  }
}
