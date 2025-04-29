
import 'package:amazon_ui/common/bottom_bar.dart';
import 'package:flutter/material.dart';

import 'screen/auth/auth_screen.dart';
import 'screen/home/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

      case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

      case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Screen does not exist!'),
            ),
          ));
  }
}
