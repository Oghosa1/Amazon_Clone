import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    // Temporary data
    List<String> orderImages = [
      'https://unsplash.com/photos/qDjDPsJ2ZSc/download?ixid=M3wxMjA3fDB8MXxhbGx8MjB8fHx8fHx8fDE3NDUxNDMyNTV8&force=true',
      'https://unsplash.com/photos/qDjDPsJ2ZSc/download?ixid=M3wxMjA3fDB8MXxhbGx8MjB8fHx8fHx8fDE3NDUxNDMyNTV8&force=true',
      'https://unsplash.com/photos/qDjDPsJ2ZSc/download?ixid=M3wxMjA3fDB8MXxhbGx8MjB8fHx8fHx8fDE3NDUxNDMyNTV8&force=true',
      'https://unsplash.com/photos/qDjDPsJ2ZSc/download?ixid=M3wxMjA3fDB8MXxhbGx8MjB8fHx8fHx8fDE3NDUxNDMyNTV8&force=true',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'See all',
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        //Display Orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
          child: ListView.builder(
            itemCount: orderImages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SingleProduct(image: orderImages[index]);
            
          }) 
        ),
      ],
    );
  }
}
