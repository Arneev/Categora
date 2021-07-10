import 'package:flutter/material.dart';

import '../../style.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  Widget? navBar;

  MyScaffold({required this.body, this.navBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      drawer: navBar,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: body,
        ),
      ),
    );
  }
}
