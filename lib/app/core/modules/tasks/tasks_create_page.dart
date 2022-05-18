// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/auth/home/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TasksCreatePage extends StatefulWidget {
    TaskCreateController _controller;

 TasksCreatePage({
    Key? key ,
    required TaskCreateController controller}) :
  _controller = controller,
   super(key: key);

  @override
   _TasksCreatePageState createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
final _descriptionEC = TextEditingController();

final _formKey = GlobalKey<FormState>();


@override
void initState(){
  super.initState();
  DefaultListenerNotifier(changeNotifier: widget._controller,
  ).listener(context: context, sucessVoidCallBack: (notifier,listenerInstance){
   listenerInstance.dispose();
   Navigator.pop(context);
  },);
  
}
  
@override
void dispose(){
  super.dispose();
  _descriptionEC.dispose();
}

   @override
   Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           automaticallyImplyLeading: false,
           elevation: 0,
           actions: [
             IconButton(onPressed: ()=> Navigator.of(context).pop(),
           
             icon:Icon(
               Icons.close,
               color: Colors.black,
               ))
           ],
         ),
         floatingActionButton: FloatingActionButton.extended(
           backgroundColor: context.primaryColor,
           onPressed: (){
             final formValid =  _formKey.currentState?.validate()?? false;
             if(formValid){
               widget._controller.save(_descriptionEC.text);
             }
           }, 
           label: Text(
             "Salvar Task",
             style: TextStyle(fontWeight: FontWeight.bold),
         
         )),
          
           body: Form(
             key:  _formKey,
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 30),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 // ignore: prefer_const_literals_to_create_immutables
                 children: [
                   Align(
                     alignment: Alignment.center,
                     child: Text("Criar Atividade",
                     style: context.titleStyle.copyWith(fontSize: 20),
                     ),
                   ),
                   SizedBox(height: 30,
                   ),
                   TodoListField(
                     label: "",
                     controller: _descriptionEC,
                     validator: Validatorless.required("Descricao e obrigatoria"),
                     ),
                   SizedBox(height: 20,
                   ),
                    CalendarButton(),
                 ],
               ),
             )),
       );
  }
}