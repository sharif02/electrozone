import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductWidget extends StatelessWidget {
  final List<Map<String, String>> products;
  final int maxItems;
  final Function(Map<String, String>) onAddToCart;

  const ProductWidget({
    super.key,
    required this.products,
    required this.onAddToCart,
    this.maxItems = 12,
  });

  @override
  Widget build(BuildContext context) {
    final visibleProducts =
        products.length > maxItems ? products.sublist(0, maxItems) : products;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visibleProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = visibleProducts[index];
        print(product);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ProductDetailScreen(
                      product: product,
                      onAddToCart:
                          (selectedProduct) => onAddToCart(selectedProduct),
                    ),
              ),
            );
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        product['image'] ?? 'assets/images/mac.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Product Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Product Details (Optional)
                if (product['details'] != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['details']!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // Product Price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product['price']!,
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
                const Spacer(),

                // Add to Cart & Buy Buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onAddToCart(product),
                          icon: const Icon(Icons.add_shopping_cart, size: 18),
                          label: const Text(
                            "Cart",
                            style: TextStyle(fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blueAccent,
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Handle Buy Now action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Buy",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
