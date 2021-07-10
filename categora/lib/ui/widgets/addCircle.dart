import 'package:flutter/material.dart';

import '../../style.dart';

class AddCircle extends StatelessWidget {
  final Function onTap;

  AddCircle({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await onTap(),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
          border: Border.all(color: mustard),
        ),
        child: MyText(text: "+", color: mustard),
      ),
    );
  }
}
