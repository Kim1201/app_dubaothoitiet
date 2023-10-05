import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  Function()? callBackSuffix;
  Icon? suffixIcon;
  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.callBackSuffix,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            suffixIcon:suffixIcon!=null? GestureDetector(
              onTap: (){
                callBackSuffix!();

              },
              child: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: suffixIcon

              ),
            ): null,


            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}