import 'dart:convert';

import 'package:amazon_ui/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'rating': rating,
    };

    // Only include id if it's not null
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      category: map['category']?.toString() ?? '',
      images:
          map['images'] != null
              ? List<String>.from(map['images'].map((x) => x?.toString() ?? ''))
              : <String>[],
      id: map['_id']?.toString(),
      rating:
          map['ratings'] != null && map['ratings'] is List
              ? List<Rating>.from(
                (map['ratings'] as List).whereType<Map<String, dynamic>>().map(
                  (x) => Rating.fromMap(x),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
