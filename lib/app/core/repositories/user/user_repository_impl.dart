// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:todo_list_provider/app/core/repositories/user/user_repository.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, por favor escolha outro email');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no TODO LIST pelo Google, por favor utilize sua conta google');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao regitsrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao fazer o login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao fazer o login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else {
        throw AuthException(
            message:
                'Cadastro realizado com o google, não pode ser recuperada a senha');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao recuperar a senha');
    }
  }

  @override
  Future<User?> googleLogin() async{
    List<String>? loginMethods;
    try{   
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if(googleUser !=null){
      loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
      if(loginMethods.contains("password")){
       throw AuthException(
         message: "Voce utilizou o e-mail para cadastro TodoList,caso tenha esquecida sua senha por favor click no link esqueci minha senha");
      }else{
        final googleAuth = await googleUser.authentication;
        final firebaseCredencial = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,idToken:googleAuth.idToken
        );
var userCredencial = await _firebaseAuth.signInWithCredential(firebaseCredencial);
return userCredencial.user;
      }
    }
  }on FirebaseAuthException catch (e,s){
    print(e);
    print(s);
    if(e.code == "account-exists-with-different-credential"){
      throw AuthException(message: """
Login invalido voce se registrou no TodoList com os seguintes provedores:
${loginMethods?.join(",")}
"""
);

    }else{
      throw AuthException(message: "Erro ao realizar login");
    }

  }
    return null;
  }

  @override
  Future<void> logout() async{
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async{
  final user = _firebaseAuth.currentUser;
  if(user != null){
    await user.updateDisplayName(name);
    user.reload();
  }
  }
}

  
