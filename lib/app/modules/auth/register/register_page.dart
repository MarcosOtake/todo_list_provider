import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_listlogo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());

    defaultListener.listener(
      context: context,
      sucessVoidCallBack: (notifier, listenerInstance) {
        listenerInstance.dispose();
       
      },
      errorVoidCallBack: (notifier, listenerInstance) {
        // ignore: avoid_print
        print('Deu Ruim Mané !!!!');
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            const SizedBox.shrink(),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              // ignore: prefer_const_constructors
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              child: TodoListlogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                      controller: _emailController,
                      label: 'E-mail',
                      validator: Validatorless.multiple([
                        Validatorless.required('Favor insira um E-mail'),
                        Validatorless.email('E-mail inválido')
                      ])),
                  const SizedBox(height: 20),
                  TodoListField(
                    controller: _passwordController,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmação obrigatória'),
                      Validatorless.compare(_passwordController,
                          'Confirmação esta diferente da senha')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValide =
                            _formKey.currentState?.validate() ?? false;
                        if (formValide) {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
