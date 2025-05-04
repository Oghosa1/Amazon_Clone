
import 'package:amazon_ui/common/bottom_bar.dart';
import 'package:amazon_ui/screen/screens/admins/add_product_screen.dart';
import 'package:flutter/material.dart';

import 'screen/auth/auth_screen.dart';
import 'screen/screens/users/home_screen.dart';

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

      case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
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
