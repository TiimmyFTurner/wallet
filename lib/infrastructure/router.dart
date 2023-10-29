import 'package:flutter/material.dart';
import 'package:wallet/presentation/pages/home_page.dart';

final routes = {
  '/home': (context) => HomePage(),
};

Route<dynamic>? generateRoute(RouteSettings settings){
  final builder = routes[settings.name];
  if(builder != null) {
    return MaterialPageRoute(builder: builder);
  }
  return null;
}

