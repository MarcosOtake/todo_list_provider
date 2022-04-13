// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatefulWidget {

  const HomeFilters({ Key? key }) : super(key: key);

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {

   @override
   Widget build(BuildContext context) {
       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("FILTROS",style: context.titleStyle,
           ),
           SizedBox(
             height: 10,
           ),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal, 
             child: Row(
               // ignore: prefer_const_literals_to_create_immutables
               children: [
                 TodoCardFilter(),
                 TodoCardFilter(),
                 TodoCardFilter(),
                 TodoCardFilter(),
                 
               ],
             ),
           )

         ],
       );
  }
}