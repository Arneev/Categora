import 'package:categora/style.dart';
import 'package:flutter/material.dart';

const double defaultPadding = 20.0;

class MyButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double padding;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;

  MyButton({
    required this.text,
    required this.onTap,
    this.padding = defaultPadding,
    this.fontSize = fontSizeMedium,
    this.fontColor = Colors.white,
    this.backgroundColor = brightRed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.all(padding),
        child: Text(
          text,
          style: TextStyle(
            color: fontColor,
            fontFamily: fontMont,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
