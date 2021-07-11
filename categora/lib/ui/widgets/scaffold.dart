import 'package:flutter/material.dart';

import '../../style.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  Widget? navBar;
  bool isScrollView;

  MyScaffold({required this.body, this.navBar, this.isScrollView = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      drawer: navBar,
      body: SafeArea(
          child: (isScrollView)
              ? SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: body,
                )
              : body),
    );
  }
}
