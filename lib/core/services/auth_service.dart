import 'dart:convert';
import 'package:amazon_ui/common/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/errror_hadling.dart';
import '../../constants/global_variable.dart';
import '../utils/utils.dart';
import '../../models/user.dart';
import 'package:http/http.dart' as http;

import '../../providers/user_provider.dart';

class AuthService {
  // Sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '',
          email: email);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account Created! Longin');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
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
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      
      print('Login response status: ${res.statusCode}');
      print('Login response body: ${res.body}');
      
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
              Provider.of<UserProvider>(context, listen: false).setUser(res.body);
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
              showSnackBar(context, 'Log in successful!');
            } else {
              print('No token in response');
              showSnackBar(context, 'Invalid response from server');
            }
          });
    } catch (e) {
      print('Login error: $e');
      showSnackBar(context, e.toString());
    }
  }

  // Get user data
  Future<bool> getUserData(
     BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token == null){
        prefs.setString('x-auth-token', '');
        return false;
      }
      
      var tokenRes = await http.post(Uri.parse('$uri/api/tokenIsValid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      }
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true){
        // get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        }
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        return true;
      }
      return false;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }
}

