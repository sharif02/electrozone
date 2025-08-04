import 'package:electro_zone/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:electro_zone/widgets/header_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/product_widget.dart';
import '../widgets/user_drawer.dart';
import 'product_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> cartItems = [];

  final List<Map<String, String>> products = [
    {
      "name": "iPhone 16e",
      "price": "\$960",
      "image": iphone16e,
      "details":
          "Display: 6.1 Super Retina XDR OLED Display Processor: A18 Bionic Chip (3nm), Storage: 128GB, 256GB Camera: 48MP Fusion: 26 mm, ƒ/1.6 aperture, 12MP ƒ/1.9 aperture Selfie features Type C, (up to 480Mb/s) Face ID, Dual ambient light sensors",
    },
    {
      "name": "iGoogle Pixel 9a",
      "price": "\$890",
      "image": googlepixel9a,
      "details": '''Model: Pixel 9a
Display: 6.3-inch FHD+ P-OLED 120Hz HDR
Processor: Google Tensor G4 (4 nm)
Camera: Dual 48MP+13MP on rear, 13MP front
Features: IP68, eSIM, Wireless Charging, Under Display Fingerprint''',
    },
    {
      "name": "iPhone 14 Pro",
      "price": "\$999",
      "image": "/images/iphone15.webp",
      "details": "Affordable and powerful smartphone.",
    },
    {
      "name": "Samsung Galaxy S24 Ultra",
      "price": "\$560",
      "image": samsungs24,
      "details": ''' Model: Galaxy S24 Ultra
Display: 6.8" Dynamic LTPO AMOLED 2X 120Hz Display
Processor: Qualcomm SM8650-AC Snapdragon 8 Gen 3 (4 nm)
Camera: Quad 200+50+10+12MP on Rear, 12MP Selfie
Features: Under Display Fingerprint, 45W Fast Charging, IP68''',
    },
    {
      "name": "MacBook Air M2",
      "price": "\$1200",
      "image": macImage,
      "details": "MacBook Air M2 is super fast and lightweight.",
    },
    {
      "name": "HP Victus Gaming 15",
      "price": "\$950",
      "image": "/images/iphone15.webp",
      "details": '''Key Features
MPN: B0HK2PA
Model: Victus Gaming 15-fb1053AX
Processor: AMD Ryzen 5 7535HS (up to 4.55 GHz, 6 cores)
RAM: 8GB DDR5, Storage: 512GB PCIe SSD
Graphics: NVIDIA GeForce RTX 2050 4GB GDDR6
Features: Backlit Keyboard, Dual Speakers, Wi-Fi 6E''',
    },
  ];

  final List<String> categories = [
    "Electronics",
    "Laptop",
    "Mobile",
    "Air buds",
  ];

  void addToCart(Map<String, dynamic> product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (existingIndex != -1) {
      setState(() {
        cartItems[existingIndex]['quantity'] =
            (cartItems[existingIndex]['quantity'] as int) + product['quantity']
                as int;
        cartItems[existingIndex]['totalPrice'] =
            (cartItems[existingIndex]['quantity'] as int) *
            double.parse(
              cartItems[existingIndex]['price'].toString().replaceAll('\$', ''),
            );
      });
    } else {
      setState(() {
        cartItems.add({
          'name': product['name'],
          'price': product['price'],
          'quantity': product['quantity'],
          'totalPrice':
              (product['quantity'] as int) *
              double.parse(product['price'].toString().replaceAll('\$', '')),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: UserDrawer(cartItems: cartItems),
      body: Container(
        decoration: _bgGradient(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(cartItems: cartItems),
                SearchWidget(),
                CategoryWidget(categories: categories),
                const SizedBox(height: 10),
                ProductWidget(
                  products: products,
                  onProductTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ProductDetailScreen(
                              product: product,
                              onAddToCart: (item) {
                                addToCart(item);
                              },
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bgGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueAccent, Colors.blue, Colors.deepPurple],
      ),
    );
  }
}
