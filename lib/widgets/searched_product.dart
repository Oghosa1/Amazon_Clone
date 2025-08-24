import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/widgets/stars.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel product;
  const SearchedProduct({super.key, required this.product});



  

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
      
      if (totalRating != 0) {
        avgRating = totalRating / product.rating!.length;
      }
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                // fit: BoxFit.contain,
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 135,
                    width: 135,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Failed to load search product image: ${product.images[0]}');
                  return Container(
                    height: 135,
                    width: 135,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stars(rating: avgRating),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '₦${product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Eligible for FREE Shipping',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
