import 'package:categora/style.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String headingText;
  Heading(this.headingText);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: -2.5,
          left: 1,
          right: -1,
          child: _Heading(
            headingText: headingText,
            color: brightRed,
          ),
        ),
        _Heading(
          headingText: headingText,
          color: mustard,
        )
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  final String headingText;
  final Color color;

  _Heading({required this.headingText, required this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              headingText,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: color,
                fontSize: fontSizeHeading,
                fontFamily: fontPacifico,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
