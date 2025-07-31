import 'package:flutter/material.dart';

import 'package:electro_zone/widgets/header_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/product_widget.dart';
import '../widgets/user_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> cartItems = []; // store with quantity
  // final List<Map<String, String>> products = List.generate(20, (index) {
  //   return {"name": "Product ${index + 1}", "price": "\$${(index + 1) * 10}"};
  // });

  final List<Map<String, String>> products = [
    {
      "name": "iPhone 15 Pro",
      "price": "\$999",
      "image": "assets/images/mac.jpg",
      "details": "iPhone 15 Pro is latest model of apple mobile brand.",
    },
    {
      "name": "MacBook Air M2",
      "price": "\$1200",
      "image": "assets/images/air_m2.jpeg",
      "details": "iPhone 15 Pro is latest model of apple mobile brand.",
    },
    {
      "name": "iPhone 14 Pro",
      "price": "\$999",
      "image": "assets/images/iphone15.jpg",
      "details": "iPhone 15 Pro is latest model of apple mobile brand.",
    },
  ];

  final List<String> categories = [
    "Electronics",
    "Laptop",
    "Mobile",
    "Air buds",
  ];

  // Add to cart logic with quantity check
  void addToCart(Map<String, String> product) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (existingItemIndex != -1) {
      // If product already in cart, just increase quantity
      cartItems[existingItemIndex]['quantity'] =
          (cartItems[existingItemIndex]['quantity'] as int) + 1;

      cartItems[existingItemIndex]['totalPrice'] =
          (cartItems[existingItemIndex]['quantity'] as int) *
          double.parse(
            cartItems[existingItemIndex]['price'].toString().replaceAll(
              '\$',
              '',
            ),
          );
    } else {
      // Add new product with quantity and totalPrice
      cartItems.add({
        'name': product['name']!,
        'price': product['price']!,
        'quantity': 1,
        'totalPrice': double.parse(product['price']!.replaceAll('\$', '')),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: UserDrawer(cartItems: cartItems),
      body: Container(
        decoration: _bgGradient(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(cartItems: cartItems),
                SearchWidget(),
                CategoryWidget(categories: categories),
                const SizedBox(height: 10),
                ProductWidget(products: products, onAddToCart: addToCart),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bgGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueAccent, Colors.blue, Colors.deepPurple],
      ),
    );
  }
}
