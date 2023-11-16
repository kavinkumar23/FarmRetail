// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/Dimensions.dart';
import 'package:login_system/configurations/SmallText.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback tapAction;
  final String text;
  final Color color;
  final IconData? icon;
  final double ButtonRadius;
  final double marginValue;
  final double padding;

  PrimaryButton(
      {super.key,
      required this.tapAction,
      required this.text,
      required this.color,
       this.icon,
      this.ButtonRadius = 10,
      this.marginValue = 15,
      this.padding = 15});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapAction,
      child: Container(
        width: double.maxFinite,
        //    height:double.nan,

        alignment: Alignment.center,
        // padding: const EdgeInsets.all(10),
        margin: EdgeInsets.all(marginValue),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(ButtonRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: Dimensions.height10,
            ),
            SmallText(
              text: text,
              color: AppColors.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
