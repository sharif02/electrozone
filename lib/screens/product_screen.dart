import 'package:flutter/material.dart';
import 'package:electro_zone/widgets/product_widget.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> allProducts;
  final Function(Map<String, dynamic>) onAddToCart; // Updated to dynamic

  const ProductScreen({
    super.key,
    required this.allProducts,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductWidget(
          products: allProducts,
          onProductTap: (product) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ProductDetailScreen(
                      product: product,
                      onAddToCart: (item) {
                        onAddToCart(
                          item,
                        ); // Pass the product with quantity to cart
                      },
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
