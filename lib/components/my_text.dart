import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String hinttext;
  final bool obscure;
  final TextEditingController controller;


  const MyTextField({
    super.key,
    required this.hinttext,
    required this.obscure,
    required this.controller,
    });

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
    
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinttext,
        ),
      ),
    );
  }
}