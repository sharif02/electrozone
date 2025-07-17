import 'package:electro_zone/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'product_screen.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> products = List.generate(20, (index) {
    return {"name": "Product ${index + 1}", "price": "\$${(index + 1) * 10}"};
  });

  final List<String> categories = [
    "Electronics",
    "Fashion",
    "Home",
    "Books",
    "Beauty",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildSearchBar(),
                  _buildCategoryList(),
                  SizedBox(height: 10),
                  _buildProductSection(context),
                ],
              ),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ElectroZone",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          OutlinedButton(
            onPressed: () => logoutUser(context),
            child: Icon(Icons.logout_outlined, color: Colors.white),
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/logo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
          hintText: 'Search products...',
          hintStyle: TextStyle(color: Colors.blueAccent.withOpacity(0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Chip(
                label: Text(categories[index]),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(color: Colors.blueAccent),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Products",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        ProductWidget(products: products, maxItems: 12),
        if (products.length > 12)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductScreen(allProducts: products),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
