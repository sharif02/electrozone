import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final List<String> categories;

  const CategoryWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
}
