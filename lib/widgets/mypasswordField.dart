import 'package:flutter/material.dart';

class MyPasswordField extends StatelessWidget {

  final TextEditingController controller;
  final String title;

  MyPasswordField({this.title,this.controller});
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
                          controller: controller,
                          obscureText: true,
                            decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility),
                            fillColor: Color(0xfff5d8e4),
                            filled: true,
                            hintText: title,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                              
                            )
                          )
                        );
  }
}