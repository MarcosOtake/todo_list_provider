// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/services/user/user_service.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeDrawer extends StatelessWidget {
  final nameVm =ValueNotifier<String>("");
  HomeDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70)
            ),
            child: Row(
            
            children: [
             
             Selector<AuthProvider,String>( selector: (context,authProvider){
             return authProvider.user?.photoURL ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5xVXwtpsTo55I4QIHcROte_oIUw9_aV8SFA&usqp=CAU";
             },builder:(_,value,__){
               return CircleAvatar(
                 backgroundImage: NetworkImage(value),
                 radius: 30,
               );
               
             }),
             Expanded(
               child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Selector<AuthProvider,String>( selector: (context,authProvider){
             return authProvider.user?.displayName ?? "Nao informado";
             },builder:(_,value,__){
               return Text(
                value,
                style: context.textTheme.subtitle2,
               );
               
             }),
           
               
            
               ),
             ),
        ],
        ),
        ),
        ListTile(
          onTap: (){
            showDialog(context: context, builder: (_){
             return AlertDialog(
                title: Text("Alterar Nome"),
                content: TextField(
                  onChanged: (value)=> nameVm.value=value,
                ),
                actions: [
                  TextButton(onPressed: ()=>Navigator.of(context).pop(),
                   
                   child: Text(
                     "Cancelar",
                    
                     style:  TextStyle(color:Colors.red),
                     ),),
                   TextButton(
                     onPressed:()async{
                     final nameValue= nameVm.value;
                     if(nameValue.isEmpty){
                       Messages.of(context)
                       .showError("Nome obrigatorio");
                     }else{
                       Loader.show(context);
                       await context.read<UserService>().updateDisplayName(nameValue);
                       Loader.hide();
                       Navigator.of(context).pop();
                     }
                   }, child:Text("Alterar"))
                ],
                 
              );
            });
          }, title:Text("Alterar Nome"),),
                  ListTile(
                   onTap: ()=> context.read<AuthProvider>().logout(),
                   title: Text("Sair"),)
                   
                 ],
              
            
        
          
       
        ),);
      
   
  }
}
