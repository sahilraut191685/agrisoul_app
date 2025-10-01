import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget{
  final controller;
  final String hindText;
  final bool obscureText;

 
  const MyTextfield({
    super.key,
    required this.controller,
    required this.hindText,
    required this.obscureText,
    
    
    });

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  const Color.fromARGB(255, 137, 212, 237)),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hindText,
            hintStyle: TextStyle(color: Colors.grey[500])
          ),
        ),
      );
  }
}