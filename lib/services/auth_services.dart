import 'dart:convert';
import 'package:amazon_ui/common/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/errror_hadling.dart';
import '../constants/global_variable.dart';
import '../utils/utils.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

import '../providers/user_provider.dart';

class AuthService {
  // Sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
        email: email,
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showToast('Account Created! Login to continue');
        },
      );
    } catch (e) {
      showToast(e.toString());
    }
  }

  // Sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting to login with email: $email');
      http.Response res = await http.post(
        Uri.parse('$uri/api/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Login response status: ${res.statusCode}');
      print('Login response body: ${res.body}');

      // Show response body directly
      print('About to show snackbar with: ${res.body}');
      // showToast(res.body);
      print('Snackbar called');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final responseData = jsonDecode(res.body);
          final token = responseData['token'] as String?;

          if (token != null) {
            print('Token received: $token');
            await prefs.setString('x-auth-token', token);

            // Filter response to only include UserModel fields
            final userJson = jsonEncode({
              '_id': responseData['_id'],
              'name': responseData['name'],
              'email': responseData['email'],
              'password': responseData['password'],
              'address': responseData['address'] ?? '',
              'type': responseData['type'] ?? '',
              'token': token,
              'cart': responseData['cart'] ?? [],
            });

            // Set the user in provider
            Provider.of<UserProvider>(context, listen: false).setUser(userJson);

            // Get the user type from the response
            final userType = responseData['type'] as String?;

            // Show success message before navigation
            // showToast(jsonDecode(res.body)['msg']);

            // Navigate based on user type
            if (userType == 'admin') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/admin', // Make sure to add this route
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName,
                (route) => false,
              );
            }
          } else {
            httpErrorHandle(
              response: res,
              context: context,
              onSuccess: () {
                showToast(jsonDecode(res.body)['msg']);
                print('Login failed: ${jsonDecode(res.body)['msg']}');
              },
            );
          }
        },
      );
    } catch (e) {
      // print('Login error: $e');
      showToast(e.toString());
      print('Login error: $e');
    }
  }

  // Get user data
  Future<bool> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      var tokenRes = await http.post(
        Uri.parse('$uri/api/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token ?? '',
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token ?? '',
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        final userData = jsonDecode(userRes.body);

        // Filter response to only include UserModel fields
        final userJson = jsonEncode({
          '_id': userData['_id'],
          'name': userData['name'],
          'email': userData['email'],
          'password': userData['password'],
          'address': userData['address'] ?? '',
          'type': userData['type'] ?? '',
          'token': userData['token'] ?? '',
          'cart': userData['cart'] ?? [],
        });

        userProvider.setUser(userJson);
        return true;
      }
      return false;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }
}
