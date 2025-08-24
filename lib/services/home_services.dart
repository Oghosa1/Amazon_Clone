import 'dart:convert';

import 'package:amazon_ui/constants/errror_hadling.dart';
import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  // Fetch Products List by Category
  Future<List<ProductModel>> fetchCategoryProduct({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          
          // Function 1
          final List<dynamic> productsJson = jsonDecode(res.body);
          productList =
              productsJson
                  .map((productMap) => ProductModel.fromMap(productMap))
                  .toList();
          
          // Debug: Check for problematic image URLs
          for (var product in productList) {
            for (var imageUrl in product.images) {
              if (imageUrl.contains('example.com')) {
                print('WARNING: Found problematic image URL in product "${product.name}": $imageUrl');
              }
            }
          }

          // Function 2
          // for (int i = 0; i < jsonDecode(res.body).length; i++) {
          //   productList.add(
          //     Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
          //   );
          // }
        },
      );
    } catch (e) {
      print('Error in fetchAllProducts: $e');
      showToast('Failed to fetch products: ${e.toString()}');
    }
    return productList;
  }

  // Fetch Deal of the Day Products
  Future<ProductModel> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // New approach: Explicitly decode the JSON first, then create the model.
          // This is more verbose but consistent with how lists of products are handled elsewhere.
          final productMap = jsonDecode(res.body) as Map<String, dynamic>;
          product = ProductModel.fromMap(productMap);
          print('Product Image: ${product.images}');
          
          // Debug: Check for problematic image URLs in deal of the day
          for (var imageUrl in product.images) {
            if (imageUrl.contains('example.com')) {
              print('WARNING: Found problematic image URL in Deal of the Day "${product.name}": $imageUrl');
            }
          }

          // Or you can use this as well
          // product = ProductModel.fromMap(jsonDecode(res.body) as Map<String, dynamic>);

          /*
          Both Work Perfectly!
          You can use either approach because:
          fromJson() internally calls jsonDecode() + fromMap()
          They produce the exact same result
          It's just a matter of preference and consistency*/

          // Old approach: Use the fromJson factory constructor.
          // This is a more concise way to achieve the same result as it handles
          // the json decoding internally.
          // product = ProductModel.fromJson(res.body);

          /*
          Which is better?

          For a single object, `ProductModel.fromJson(res.body)` is more concise and perfectly acceptable.
          However, the explicit two-step process (`jsonDecode` then `fromMap`) is used when handling lists of objects,
          as seen in `fetchCategoryProduct`.

          Using the two-step process here makes the code more consistent in its style, which can improve
          readability and maintainability in the long run. Therefore, the explicit approach is slightly
          preferred for consistency within this specific file.
          */
        },
      );
    } catch (e) {
      print('Error in fetchAllProducts: $e');
      showToast('Failed to fetch products: ${e.toString()}');
    }
    return product;
  }
}
