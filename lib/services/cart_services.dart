import 'dart:convert';
import 'package:amazon_ui/constants/errror_hadling.dart';
import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/models/user_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  // Remove from cart
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final responseBody = jsonDecode(response.body);
          // Backend returns { message: "...", user: {...} }
          // Use UserModel.fromMap to properly handle type conversion
          final userData = responseBody['user'] as Map<String, dynamic>;

          // Preserve the existing token since cart operations don't return it
          userData['token'] = userProvider.user.token;

          UserModel userModel = UserModel.fromMap(userData);
          userProvider.setUserFromModel(userModel);

          // Extract the message from the backend response
          final message =
              responseBody['message'] ??
              'Product removed from cart successfully!';
          showToast(message);
          print('Cart updated successfully');
        },
      );
    } catch (e, stackTrace) {
      // It's good practice to log the full error and stack trace for debugging
      print('Error in removeFromCart: $e');
      print('Stack trace: $stackTrace');
      print('This is the error: $e');
      showToast(e.toString());
    }
  }
}
