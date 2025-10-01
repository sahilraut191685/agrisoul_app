import 'package:flutter/material.dart';
import '../pages/home_page.dart';



class MyButton extends StatelessWidget {
 final void Function()? onTap;

  const MyButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
          Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> const HomePage()),
          );
      },
      child: Container
      (
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          ),
        child: const Center(
          
          child: Text(
            'Sign In',
            style: TextStyle
            (
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ) ,
            ),
          ),
      ),
    );
  }
}