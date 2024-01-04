import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/presentation/screens/add_credit_card_screen.dart';
import 'package:wallet/presentation/screens/home_screen.dart';


final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(path: '/',builder: (BuildContext context, GoRouterState state){
    return const HomeScreen();

  },routes: <RouteBase>[
    GoRoute(
      path: 'addCreditCard',
      builder: (BuildContext context, GoRouterState state) {
        return const AddCreditCardScreen();
      },
    ),
  ],)
]);