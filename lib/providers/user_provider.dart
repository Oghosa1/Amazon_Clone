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
    return ProductModel.fromMap(_userModel.cart[index]['product']);
  }

  // Get the quantity of a cart item (how many of this product are in cart)
  int getCartQuantity(int index) {
    return _userModel.cart[index]['quantity'] ?? 0;
  }
}
