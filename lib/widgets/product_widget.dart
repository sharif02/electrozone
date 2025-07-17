import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final List<Map<String, String>> products;
  final int maxItems;

  const ProductWidget({super.key, required this.products, this.maxItems = 12});

  @override
  Widget build(BuildContext context) {
    final visibleProducts =
        products.length > maxItems ? products.sublist(0, maxItems) : products;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: visibleProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = visibleProducts[index];

        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Area
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Center(
                  child: Icon(Icons.image, color: Colors.blueAccent, size: 50),
                ),
              ),

              // Product Name
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6,
                ),
                child: Text(
                  product['name']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              // Product Price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product['price']!,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                ),
              ),

              Spacer(),

              // Buttons Row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Add to Cart Button with Icon
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Add to cart logic
                        },
                        icon: Icon(Icons.add_shopping_cart, size: 18),
                        label: Text("Cart", style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                          side: BorderSide(color: Colors.blueAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    // Buy Now Button
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Buy now logic
                        },
                        child: Text("Buy", style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
