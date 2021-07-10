import 'package:categora/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';

Route<dynamic> materialRouteWrap(Widget widget, RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => widget,
  );
}
