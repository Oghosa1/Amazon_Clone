import 'dart:io';

import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/utils/utils.dart';
import 'package:amazon_ui/services/admin_services.dart';
import 'package:amazon_ui/widgets/custom_button.dart';
import 'package:amazon_ui/widgets/custom_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController1 = TextEditingController();
  final TextEditingController descriptionController2 = TextEditingController();
  final TextEditingController priceController3 = TextEditingController();
  final TextEditingController quantityController4 = TextEditingController();
  final AdminServices adminServices = AdminServices();

  final _addProductFormKey = GlobalKey<FormState>();

  // String? selectedCategory;

  // List<String> productCategories = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Extract category titles from GlobalVariables
  //   productCategories = GlobalVariables.categoryImages
  //       .map((category) => category['title'] as String)
  //       .toList();
  //   // Set default selected category
  //   selectedCategory = productCategories.isNotEmpty ? productCategories[0] : null;
  // }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  List<File> images = [];

  String category = 'Mobiles';

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      try {
        // Validate that price and quantity are valid numbers
        final double price = double.parse(priceController3.text.trim());
        final double quantity = double.parse(quantityController4.text.trim());
        
        if (price <= 0) {
          showToast('Price must be greater than 0');
          return;
        }
        
        if (quantity <= 0) {
          showToast('Quantity must be greater than 0');
          return;
        }
        
        adminServices.sellProduct(
          name: productNameController1.text.trim(),
          description: descriptionController2.text.trim(),
          price: price,
          quantity: quantity,
          category: category,
          images: images,
          context: context,
        );
      } catch (e) {
        showToast('Please enter valid price and quantity values');
      }
    } else if (images.isEmpty) {
      showToast('Please select at least one product image');
    }
  }

  @override
  void dispose() {
    productNameController1.dispose();
    descriptionController2.dispose();
    priceController3.dispose();
    quantityController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text('Add Product', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                images.isNotEmpty
                    ? CarouselSlider(
                      items:
                          images.map((i) {
                            return Builder(
                              builder:
                                  (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                            );
                          }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                    : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        padding: const EdgeInsets.all(
                          20,
                        ), // Added padding around the content
                        strokeWidth: 2, // Increased stroke width for visibility
                        dashPattern: const [10, 5],
                        strokeCap: StrokeCap.round, // Adjusted dash pattern
                        child: Container(
                          width: double.infinity,
                          height: 180, // Increased height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center, // Center content vertically
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 50,
                              ), // Increased icon size
                              const SizedBox(height: 20), // Increased spacing
                              const Text(
                                'Add Product Images',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ), // Increased font size
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController1,
                  hintText: "Product Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController2,
                  hintText: "Description",
                  maxLines: 7,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController3,
                  hintText: "Price",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    final price = double.tryParse(value.trim());
                    if (price == null || price <= 0) {
                      return 'Please enter a valid price greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController4,
                  hintText: "Quantity",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Quantity is required';
                    }
                    final quantity = double.tryParse(value.trim());
                    if (quantity == null || quantity <= 0) {
                      return 'Please enter a valid quantity greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(text: 'Sell', onTap: sellProduct),

                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.black38,
                //     ),
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: DropdownButton<String>(
                //     value: selectedCategory,
                //     icon: const Icon(Icons.keyboard_arrow_down),
                //     isExpanded: true,
                //     underline: const SizedBox(),
                //     hint: const Text('Select Category'),
                //     items: productCategories.map((String category) {
                //       return DropdownMenuItem(
                //         value: category,
                //         child: Text(category),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedCategory = newValue;
                //       });
                //     },
                //   ),
                // ),
                // const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
