import 'package:flutter/material.dart';

import 'package:plant_app/themes/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.height = 45.0,
    this.onTap,
  });

  final String text;
  final double height;
  final Function()? onTap;


  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.kDarkGreenColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16 , color: Colors.white ),
        ),
      ),
    );
  }
}