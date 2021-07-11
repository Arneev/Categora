import 'dart:async';

import 'package:flutter/material.dart';

import '../../style.dart';
import 'button.dart';

AlertDialog myAlertDialog({
  required String title,
  required List<Widget> content,
  required List<Widget> buttons,
  Widget? extraWidget,
  double fontScale = 1.3,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    backgroundColor: darkNavyBlue,
    title: (extraWidget == null)
        ? MyText(text: title, color: mustard)
        : Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyText(
                      text: title,
                      color: mustard,
                      fontSize: fontSizeSmall * fontScale),
                  extraWidget,
                ],
              ),
            ),
          ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MySpacing(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content,
            ),
          ),
          MySpacing(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ],
      ),
    ),
  );
}

class MyAlertButton extends StatelessWidget {
  late final dynamic onTap;
  late final String text;

  MyAlertButton({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      text: text,
      padding: 10,
      fontSize: fontSizeSmall,
      onTap: () async {
        await onTap();
      },
    );
  }
}
