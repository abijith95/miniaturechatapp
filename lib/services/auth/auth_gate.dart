
import 'package:chatapp/services/auth/login_or_register.dart';
import 'package:chatapp/pages/home.dart';
import 'package:chatapp/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot){
          //if user is logged in ::::
          if(snapshot.hasData)
          {
            return HomePage();
          }

          //if not logged in ::::::
          else{
            return LoginOrRegister();
          }

        })
    );
  }
}