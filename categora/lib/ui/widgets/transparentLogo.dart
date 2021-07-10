import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransparentLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Align(
        heightFactor: 0.4,
        child: SvgPicture.asset(
          "assets/images/transparentLogo.svg",
        ),
      ),
    );
  }
}
