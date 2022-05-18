// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget{
  HomeHeader({Key?key}): super(key:key);


  @override
  Widget build(BuildContext context) {
      return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:20),
          child: Selector<AuthProvider,String>(
            selector:(context,authProvider)=>authProvider.user?.displayName ?? "Nao informado",
            builder:(_,value,__){
             return Text(
            "E ai ,$value",
            style: context.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold
            ),
             );
          }),
        )
      ],
      );
        
          
          
      
  }}