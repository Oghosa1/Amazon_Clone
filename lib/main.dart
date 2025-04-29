import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/router.dart';
import 'package:amazon_ui/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/auth/auth_screen.dart';
import 'package:amazon_ui/common/bottom_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserData(context);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.teal,
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:
          Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? const BottomBar()
              : const AuthScreen(),
    );
  }
}
