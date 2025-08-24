import 'dart:convert';
import 'dart:io';
import 'package:amazon_ui/constants/errror_hadling.dart';
import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/models/user_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  // Add to cart
  // Rate Product
  void addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final responseBody = jsonDecode(response.body);
          // Backend returns { message: "...", user: {...} }
          // Extract cart from the user object
          final cart = responseBody['user']?['cart'] ?? [];
          
          UserModel userModel = userProvider.user.copyWith(
            cart: cart,
          );
          userProvider.setUserFromModel(userModel);
          
          // Extract the message from the backend response
          final message =
              responseBody['message'] ?? 'product added to cart successfully!';
          showToast(message);
          print('This is the cart: $message.toString');
          print('This is the message: $message');
        },
      );
    } catch (e, stackTrace) {
      // It's good practice to log the full error and stack trace for debugging
      print('Error in addToCart: $e');
      print('Stack trace: $stackTrace');
      print('This is the error: $e');
      showToast(e.toString());
    }
  }

  // Rate Product
  void rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/products/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!, 'rating': rating}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // showToast('Product Added Successfully!');
          // Extract the message from the backend response
          final responseBody = jsonDecode(response.body);
          final message =
              responseBody['message'] ?? 'Thank you for rating the product';
          showToast(message);
          print('This is the message: $message');
          // Navigator.pop(context);
        },
      );
    } catch (e, stackTrace) {
      // It's good practice to log the full error and stack trace for debugging
      print('Error in sellProduct: $e');
      print(stackTrace);
      String errorMessage = 'Failed to sell product';
      if (e is http.ClientException) {
        errorMessage += ': ${e.message}';
      } else if (e is SocketException) {
        errorMessage += ': Network error';
      } else if (e is FormatException) {
        errorMessage += ': Invalid response format';
      } else {
        errorMessage += ': ${e.toString()}';
      }
      showToast(errorMessage);
    }
  }
}
