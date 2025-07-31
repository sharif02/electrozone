import 'package:electro_zone/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const HeaderWidget({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "ElectroZone",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Row(
            children: [
              // Cart Icon
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),

              // Profile Avatar
              GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/logo.jpg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
