import 'package:flutter/material.dart';

import '../../style.dart';

class TextTap extends StatelessWidget {
  final String text;
  final Function onTap;

  TextTap({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontMont,
          fontSize: fontSizeMedium,
          color: mustard,
        ),
      ),
    );
  }
}
