import 'package:electro_zone/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const UserDrawer({super.key, required this.cartItems});
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
              logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}
