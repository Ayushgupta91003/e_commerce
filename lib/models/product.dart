// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
  });

  // Convert Product to a Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
    };
  }

  // Create Product from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      images: List<String>.from(map['images'] as List<dynamic>),
      category: map['category'] as String,
      price: (map['price'] as num).toDouble(),
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }

  // Convert Product to JSON
  String toJson() => json.encode(toMap());

  // Create Product from JSON
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
