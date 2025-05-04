import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/widgets/custom_text_field.dart';
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

  String category = 'Mobiles';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                DottedBorder(
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
                          MainAxisAlignment.center, // Center content vertically
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
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController1,
                  hintText: "Product Name",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController2,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController3,
                  hintText: "Price",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController4,
                  hintText: "Quantity",
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
