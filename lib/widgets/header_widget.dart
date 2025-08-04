import 'package:electro_zone/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const HeaderWidget({super.key, required this.cartItems});

  int getTotalQuantity() {
    int totalQty = 0;
    for (var item in cartItems) {
      totalQty += item['quantity'] as int;
    }
    return totalQty;
  }

  @override
  Widget build(BuildContext context) {
    final totalQuantity = getTotalQuantity();

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
              // Cart Icon with total quantity badge
              Stack(
                children: [
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
                  if (totalQuantity > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          totalQuantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("/images/logo.jpeg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
