import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:electro_zone/widgets/header_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/product_widget.dart';
import 'login_screen.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> products = List.generate(20, (index) {
    return {"name": "Product ${index + 1}", "price": "\$${(index + 1) * 10}"};
  });

  final List<String> categories = [
    "Electronics",
    "Laptop",
    "Mobile",
    "Air burds",
  ];

  HomePage({super.key});

  Future<void> logoutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 10),
                ProductWidget(products: products),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bgGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueAccent, Colors.blue, Colors.deepPurple],
      ),
    );
  }
}
