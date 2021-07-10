import 'package:categora/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureFlag;
  final double padding;
  final double fontSize;

  MyTextField({
    required this.controller,
    required this.hintText,
    this.obsecureFlag = false,
    this.padding = 15,
    this.fontSize = fontSizeMedium,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(
          left: padding,
          right: padding,
          bottom: padding,
          top: padding * (2 / 3)),
      child: TextField(
        controller: controller,
        maxLines: 1,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
        ),
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: fontMont,
          fontWeight: FontWeight.w500,
        ),
        obscureText: obsecureFlag,
      ),
    );
  }
}
