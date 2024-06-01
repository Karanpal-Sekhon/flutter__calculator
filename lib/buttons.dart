// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  // Variables that button needs
  final color; // color of the button
  final text_color; // color of the text
  final String button_text; // actual text going on the calculator
  final buttonTapped;

  const Mybutton({super.key, this.color, this.text_color, required this.button_text, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color, // color that we passed into the button object
            child: Center(child: Text(button_text, style: TextStyle(color: text_color, fontSize: 20),),) // text that we passed into the app, color of text is text_color
          ),
          ),
      ),
    );
  }
}