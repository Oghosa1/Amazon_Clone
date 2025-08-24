import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/screen/features/product_details_screen.dart';
import 'package:amazon_ui/services/home_services.dart';
import 'package:amazon_ui/widgets/loader.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductModel? product;
  final HomeServices homeServices = HomeServices();

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
        ? const SizedBox()
        : GestureDetector(
          onTap: navigateToDetailScreen,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text('Deal of the Day', style: TextStyle(fontSize: 20)),
              ),
              Image.network(
                product!.images[0],
                height: 235,
                fit: BoxFit.fitHeight,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 235,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Failed to load deal image: ${product!.images[0]}');
                  return Container(
                    height: 235,
                    color: Colors.grey[200],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.grey, size: 60),
                        SizedBox(height: 8),
                        Text(
                          'Deal image unavailable',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
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
                  children:
                      // [
                      //   ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: product!.images.length,
                      //     itemBuilder: (context, index) {
                      //       return Image.network(
                      //         product!.images[index],
                      //         fit: BoxFit.fitWidth,
                      //         width: 100,
                      //         height: 100,
                      //       );
                      //     },
                      //   ),
                      // ],
                      product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.fitWidth,
                              width: 100,
                              height: 100,
                              errorBuilder: (context, error, stackTrace) {
                                print('Failed to load deal image: $e');
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ).copyWith(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'See all deals',
                  style: TextStyle(fontSize: 15, color: Colors.cyan[800]),
                ),
              ),
            ],
          ),
        );
  }
}
