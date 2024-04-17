import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  
  bool showlogin = true;

  //Login or register

  void togglepage(){
    setState(() {
      showlogin = !showlogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showlogin)
    {
      return LoginPage(
        onTap: togglepage,
      );
    }
    else{
      return RegisterPage(
        onTap: togglepage,
      );
    }
  }
}