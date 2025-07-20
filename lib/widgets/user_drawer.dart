import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const UserDrawer({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            accountName: Text("Shariful Billah"),
            accountEmail: Text("sharif@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.jpg"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile Info"),
            onTap: () {},
          ),
          ExpansionTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Cart Items"),
            children:
                cartItems.isEmpty
                    ? [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Cart is empty"),
                      ),
                    ]
                    : cartItems.map((item) {
                      return ListTile(
                        title: Text("${item['name']} (x${item['quantity']})"),
                        subtitle: Text(item['price']),
                      );
                    }).toList(),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment Info"),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
