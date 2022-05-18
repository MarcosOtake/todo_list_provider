// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/auth/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/todo_card_filter.dart';
import 'package:todo_list_provider/app/modules/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/total_tasks_model.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);
 
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
                 TodoCardFilter(
                   label: "HOJE",
                   taskFilter: TaskFilterEnum.today,
                   totalTasksModel: context.select<HomeController,TotalTasksModel?>((controller) => controller.todayTotalTasks),
                    selected: context.select<HomeController,TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.today,
                 ),
                 TodoCardFilter(
                    label: "AMANHA",
                    taskFilter: TaskFilterEnum.tomorrow,
                    totalTasksModel:context.select<HomeController,TotalTasksModel?>((controller) => controller.tomorrowTotalTasks),
                    selected: context.select<HomeController,TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.tomorrow,
                 ),
                 TodoCardFilter(
                   label: "SEMANA",
                   taskFilter: TaskFilterEnum.week,
                   totalTasksModel:context.select<HomeController,TotalTasksModel?>((controller) => controller.weekTotalTasks),
                  selected: context.select<HomeController,TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.week,
                 ),
                 
                 
               ],
             ),
           )

         ],
       );
  }
}