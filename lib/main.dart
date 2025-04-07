
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/global_variable.dart';
import 'screen/auth_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(

          seedColor: GlobalVariables.backgroundColor,
          surface: GlobalVariables.secondaryColor,
          secondary: GlobalVariables.secondaryColor,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen()
    );
  }
}
