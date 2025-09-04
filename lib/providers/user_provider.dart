import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../models/product_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
    id: '',
    name: '',
    password: '',
    email: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  UserModel get user => _userModel;

  // Handles authentication flows by setting user data from API JSON responses
  // Used in: Login process, token validation on app startup
  // Receives: Raw JSON string from backend (contains user info + auth token)
  // Purpose: Converts API response to UserModel and updates global state
  void setUser(String user) {
    _userModel = UserModel.fromJson(user);
    notifyListeners();
  }

  // Handles state updates when user data changes during app usage
  // Used in: Shopping cart updates, profile modifications, copyWith operations
  // Receives: Already-created UserModel object (from copyWith or other sources)
  // Purpose: Updates global state without JSON parsing, triggers UI rebuilds
  void setUserFromModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  // Easy way to get a cart product as a ProductModel
  ProductModel getCartProduct(int index) {
    final productData = _userModel.cart[index]['product'];

    // Handle case where product might be stored as JSON string or Map
    if (productData is String) {
      // Check if it's a valid JSON string or just an ID
      try {
        if (productData.startsWith('{') && productData.endsWith('}')) {
          // If it's a JSON string, decode it first
          final Map<String, dynamic> productMap = json.decode(productData);
          return ProductModel.fromMap(productMap);
        } else {
          // If it's just an ID string, return a minimal product with defaults
          return ProductModel(
            id: productData,
            name: '',
            description: '',
            price: 0.0,
            quantity: 0.0,
            category: '',
            images: const <String>[],
          );
        }
      } catch (e) {
        // If parsing fails, still fall back to minimal product using the ID
        return ProductModel(
          id: productData,
          name: '',
          description: '',
          price: 0.0,
          quantity: 0.0,
          category: '',
          images: const <String>[],
        );
      }
    } else if (productData is Map<String, dynamic>) {
      // If it's already a Map, use it directly
      return ProductModel.fromMap(productData);
    } else {
      // Fallback for unexpected data types
      throw Exception(
        'Unexpected product data type in cart: ${productData.runtimeType}',
      );
    }
  }

  // Get the quantity of a cart item (how many of this product are in cart)
  int getCartQuantity(int index) {
    return _userModel.cart[index]['quantity'] ?? 0;
  }
}
