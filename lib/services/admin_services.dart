import 'dart:convert';
import 'dart:io';

import 'package:amazon_ui/constants/errror_hadling.dart';
import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {

  // Sell Product 
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dt0bnqugj', 'ow8l0s3n');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      // Add logic here to save the product details along with imageUrls to your backend
      ProductModel product = ProductModel(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      print('Sending product data: ${product.toJson()}');
      print('Request URL: $uri/admin/add-product');

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // showToast('Product Added Successfully!');
          // Extract the message from the backend response
          final responseBody = jsonDecode(response.body);
          final message =
              responseBody['message'] ?? 'Product Added Successfully!';
          showToast(message);
          Navigator.pop(context);
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

  // Get all products from the server
  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
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

  // Delete Product
  void deleteProduct({
    required BuildContext context,
    required ProductModel product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
          //  final responseBody = jsonDecode(response.body);
          //  final message =
          //     responseBody['message'] ?? 'Product Added Successfully!';
          // showToast(message);
          showToast(jsonDecode(response.body)['message']);
          // showToast('Product deleted successfully');
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






// Get all products
//   Future<List<Product>> fetchAllProducts(BuildContext context) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     List<Product> productList = [];
    
//     try {
//       http.Response res = await http.get(
//         Uri.parse('$uri/admin/get-products'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//       );

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           // Parse JSON once and convert efficiently
//           final List<dynamic> productsJson = jsonDecode(res.body);
//           productList = productsJson
//               .map((productMap) => Product.fromMap(productMap))
//               .toList();
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
    
//     return productList;
//   }
// }
