import 'package:amazon_ui/screen/screens/admins/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Products')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Product',
        onPressed:navigateToAddProductScreen,
        child: const Icon(Icons.add)
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,);
  }
}
