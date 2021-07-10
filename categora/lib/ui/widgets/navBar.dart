import 'dart:ui';

import 'package:categora/services/Router.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/widgets/transparentLogo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.5,
        sigmaY: 1.5,
      ),
      child: Container(
        width: size.width * 0.6,
        color: Colors.white10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _RotatingLogo(),
            NavButton(
              name: "Categories",
              onTap: () => goToCategories(context),
            ),
            NavButton(
              name: "Tasks",
              onTap: () => goToTasks(context),
            ),
            NavButton(
              name: "Settings",
              onTap: () => goToSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  late final Function onTap;
  late final String name;

  NavButton({
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        color: Colors.black54,
        alignment: Alignment.center,
        child: MyText(text: name, color: mustard),
      ),
    );
  }
}

class _RotatingLogo extends StatefulWidget {
  @override
  __RotatingLogoState createState() => __RotatingLogoState();
}

class __RotatingLogoState extends State<_RotatingLogo>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 20))
        ..repeat();

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.linear);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: TransparentLogo(),
    );
  }
}
