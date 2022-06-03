// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/task_model.dart';

class Task extends StatelessWidget {
final TaskModel model;
final dateFormat = DateFormat("dd/MM/y");
  Task({ Key? key,required this.model }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Container(
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20),
           // ignore: prefer_const_literals_to_create_immutables
           boxShadow: [
             BoxShadow(color: Colors.grey),
           
           ]
             
         ),
         margin: EdgeInsets.symmetric(vertical: 5),
         child: IntrinsicHeight(
           child:ListTile(
             contentPadding: EdgeInsets.all(8),
             leading: Checkbox(
               value: model.finished,
               onChanged: (value)=>context.read<HomeController>().checkOrUnchTask(model),

               
               ),
               title: Text(
                 model.description,
               style: TextStyle(
                 decoration: model.finished ? TextDecoration.lineThrough : null),
               ),
               subtitle: Text(
                dateFormat.format(model.dateTime),
               style:TextStyle(
                 decoration: model.finished ? TextDecoration.lineThrough : null),
               ),
               shape: RoundedRectangleBorder(
                 borderRadius:BorderRadius.circular(20),
                 side: BorderSide(width: 1)
                  ),
           ) ),
       );
  }
}