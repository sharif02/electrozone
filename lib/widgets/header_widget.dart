import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const HeaderWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
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
            onPressed: onLogout,
            child: Icon(Icons.logout_outlined, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {}, // Later use for drawer or user profile
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/logo.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}
