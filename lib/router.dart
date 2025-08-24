import 'package:amazon_ui/common/bottom_bar.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/screen/admins/add_product_screen.dart';
import 'package:amazon_ui/screen/admins/admin_screen.dart';
import 'package:amazon_ui/screen/features/address_screen.dart';
import 'package:amazon_ui/screen/features/product_details_screen.dart';
import 'package:amazon_ui/screen/features/search_screen.dart';
import 'package:amazon_ui/screen/users/category_deals_screen.dart';
import 'package:flutter/material.dart';

import 'screen/auth/auth_screen.dart';
import 'screen/users/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );

    case ProductDetailsScreen.routeName:
      var searchProductQuery = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: searchProductQuery),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
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

      case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddressScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

    case '/admin':
      return MaterialPageRoute(builder: (_) => const AdminScreen());

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:
            (_) => const Scaffold(
              body: Center(child: Text('Screen does not exist!')),
            ),
      );
  }
}