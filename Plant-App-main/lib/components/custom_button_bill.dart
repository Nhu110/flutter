import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
     return ElevatedButton(
      onPressed: onPressed,
      // ignore: sort_child_properties_last
      child: Text(text),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
         Color.fromARGB(255, 104, 255, 162)))
    );
  }
}