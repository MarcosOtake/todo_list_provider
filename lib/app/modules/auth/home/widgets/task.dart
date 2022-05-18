// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';

class Task extends StatelessWidget {

  const Task({ Key? key }) : super(key: key);

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
               value: true,
               onChanged: (value){},
               ),
               title: Text("Descricao da TASK",
               style: TextStyle(
                 decoration: false? TextDecoration.lineThrough : null),
               ),
               subtitle: Text("07/04/2022",
               style:TextStyle(
                 decoration: false? TextDecoration.lineThrough : null),
               ),
           ) ),
       );
  }
}