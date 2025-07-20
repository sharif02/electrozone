import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:electro_zone/widgets/header_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/product_widget.dart';
import 'login_screen.dart';
import '../widgets/user_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> cartItems = []; // store with quantity
  final List<Map<String, String>> products = List.generate(20, (index) {
    return {"name": "Product ${index + 1}", "price": "\$${(index + 1) * 10}"};
  });

  final List<String> categories = [
    "Electronics",
    "Laptop",
    "Mobile",
    "Air buds",
  ];

  Future<void> logoutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  // Add to cart logic with quantity check
  void addToCart(Map<String, String> product) {
    setState(() {
      final index = cartItems.indexWhere(
        (item) => item['name'] == product['name'],
      );
      if (index != -1) {
        cartItems[index]['quantity'] += 1; // increase quantity
      } else {
        cartItems.add({
          "name": product['name'],
          "price": product['price'],
          "quantity": 1,
        });
      }
    });
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
                HeaderWidget(onLogout: () => logoutUser(context)),
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
