// lib/screens/product_screen.dart
import 'package:flutter/material.dart';
import 'package:electro_zone/widgets/product_widget.dart';

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> allProducts;

  const ProductScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductWidget(products: allProducts, maxItems: 1000), // show all
      ),
    );
  }
}
