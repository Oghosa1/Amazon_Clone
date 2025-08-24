import 'package:amazon_ui/models/product_model.dart';
import 'package:amazon_ui/providers/user_provider.dart';
import 'package:amazon_ui/services/cart_services.dart';
import 'package:amazon_ui/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity({
    required BuildContext context,
    required ProductModel productId,
  }) {
    productDetailsServices.addToCart(context: context, product: productId);
  }

  void decreaseQuantity({
    required BuildContext context,
    required ProductModel productId,
  }) {
    cartServices.removeFromCart(context: context, product: productId);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    // Get product and quantity separately using clean helper methods
    final product = userProvider.getCartProduct(widget.index);
    final quantity = userProvider.getCartQuantity(widget.index);
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
                  print(
                    'Failed to load search product image: ${product.images[0]}',
                  );
                  return Container(
                    height: 135,
                    width: 135,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
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
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(fontSize: 12, color: Colors.green),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () => decreaseQuantity(
                    context: context,
                    productId: product,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove, size: 18),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap:
                            () => increaseQuantity(
                              context: context,
                              productId: product,
                            ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(Icons.add, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
