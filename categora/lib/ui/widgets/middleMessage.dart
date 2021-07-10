import 'package:flutter/material.dart';

import '../../style.dart';

class MiddleMessage extends StatelessWidget {
  late final String message;

  MiddleMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mustard,
          fontFamily: fontMont,
          fontSize: fontSizeLarge,
        ),
      ),
    );
  }
}
