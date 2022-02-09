import 'package:flutter/material.dart';
import 'package:free_reads/screens/screens.dart';

class CustomRouter {
  onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return routeGenerator(const CategoryScreen());
      default:
        return routeGenerator(const CategoryScreen());
    }
  }
}

routeGenerator(Widget widget) {
  return MaterialPageRoute(builder: (context) {
    return widget;
  });
}
