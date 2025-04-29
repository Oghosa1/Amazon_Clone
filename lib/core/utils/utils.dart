import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(BuildContext context, String text) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}


// import 'package:flutter/material.dart';

// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }