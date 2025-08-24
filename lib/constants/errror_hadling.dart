import 'dart:convert';


import 'package:amazon_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch(response.statusCode) {
    case 200: // OK
    case 201: // Created
    case 202: // Accepted
    case 204: // No Content
      onSuccess();
      break;
    case 400: // Bad Request
      showToast(jsonDecode(response.body)['msg'] ?? 'Bad request');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 401: // Unauthorized
      showToast(jsonDecode(response.body)['msg'] ?? 'Unauthorized access');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 403: // Forbidden
      showToast(jsonDecode(response.body)['msg'] ?? 'Access forbidden');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 404: // Not Found
      showToast(jsonDecode(response.body)['msg'] ?? 'Resource not found');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 409: // Conflict
      showToast(jsonDecode(response.body)['msg'] ?? 'Conflict occurred');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 422: // Unprocessable Entity
      showToast(jsonDecode(response.body)['msg'] ?? 'Invalid data provided');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['msg']}');
      break;
    case 500: // Internal Server Error
      showToast(jsonDecode(response.body)['error'] ?? 'Server error occurred');
      print('Error in httpErrorHandle: ${jsonDecode(response.body)['error']}');
      break;
    case 502: // Bad Gateway
      showToast('Server is temporarily unavailable');
      print('Error in httpErrorHandle: Bad Gateway (502)');
      break;
    case 503: // Service Unavailable
      showToast('Service temporarily unavailable');
      print('Error in httpErrorHandle: Service Unavailable (503)');
      print('Response body in 503: ${response.body}');
      break;
    default:
      showToast('An unexpected error occurred');
      print('Error in httpErrorHandle: Unexpected status code ${response.statusCode}');
      print('Response body: ${response.body}');
  }
}
