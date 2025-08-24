import 'dart:convert';
import 'package:amazon_ui/constants/errror_hadling.dart';
import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<ProductModel>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

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

          // Function 2
          // for (int i = 0; i < jsonDecode(res.body).length; i++) {
          //   productList.add(
          //     Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
          //   );
          // }

          print('Parsed ${productList.length} products');
        },
      );
    } catch (e) {
      print('Error in fetchAllProducts: $e');
      showToast('Failed to fetch products: ${e.toString()}');
    }
    return productList;
  }
}
