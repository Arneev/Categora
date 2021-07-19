import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransparentLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Align(
          heightFactor: 0.4,
          child: SvgPicture.asset(
            "assets/images/transparentLogo.svg",
          ),
        ),
      ),
    );
  }
}
