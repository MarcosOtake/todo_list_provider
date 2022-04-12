import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_listlogo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      sucessVoidCallBack: (notifier, listenerInstance) {
        // ignore: avoid_print
        print('Login efetuado com sucesso!!!');
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const TodoListlogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TodoListField(
                                controller: _emailController,
                                label: 'E-mail',
                                focusNode: _emailFocus,
                                validator: Validatorless.multiple([
                                  Validatorless.required('E-mail obrigatório'),
                                  Validatorless.email('E-mail inválido'),
                                ]),
                              ),
                              const SizedBox(height: 20),
                              TodoListField(
                                controller: _passwordController,
                                label: 'Senha',
                                obscureText: true,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Senha obrigatória'),
                                  Validatorless.min(6,
                                      'Senha deve conter no mínimo 6 caracteres'),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (_emailController.text.isNotEmpty) {
                                        context
                                            .read<LoginController>()
                                            .forgotPassword(_emailController.text);
                                      } else {
                                        _emailFocus.requestFocus();
                                        Messages.of(context).showError(
                                            'Digite um e-mail para recuperar a sua senha');
                                      }
                                    },
                                    child: const Text('Esqueceu sua senha?'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      final formvalid =
                                          _formKey.currentState?.validate() ??
                                              false;
                                      if (formvalid) {
                                        context
                                            .read<LoginController>()
                                            .login(email, password);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Login'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0XffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              SignInButton(
                                Buttons.Google,
                                text: 'Continue com o Google',
                                padding: const EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                onPressed: () {
                                 context.read<LoginController>().googleLogin(); 
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem conta? '),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/register');
                                      },
                                      child: const Text('Cadastre-se'))
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
