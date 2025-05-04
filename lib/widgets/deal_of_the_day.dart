import 'package:amazon_ui/constants/global_variable.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: Text('Deal of the Day', style: TextStyle(fontSize: 20)),
        ),
        Image.network(
          GlobalVariables.dealOfTheDay,
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            '\$${3000}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: Text(
            'Get it by Tomorrow, 8:00 PM',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                GlobalVariables.products,
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                GlobalVariables.products,
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                GlobalVariables.products,
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                GlobalVariables.products,
                fit: BoxFit.fitWidth,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text('See all deals', style: TextStyle(fontSize: 15, color: Colors.cyan[800])),
        ),
      ],
    );
  }
}
