import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import '../widgets/toast_meesage.dart';

class PaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const PaymentScreen({super.key, required this.products});

  // ✅ Calculate total amount dynamically from cart items
  double calculateTotalAmount() {
    double total = 0.0;
    for (var product in products) {
      final price =
          double.tryParse(product['price'].toString().replaceAll('\$', '')) ??
          0;
      final quantity = (product['quantity'] as int?) ?? 1;
      total += price * quantity;
    }
    return total;
  }

  // ✅ SSLCommerz Payment Integration
  Future<void> sslCommerz(BuildContext context) async {
    double totalAmount = calculateTotalAmount();
    log("Initializing SSLCommerz for amount: $totalAmount");

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "E-commerce",
        sdkType: SSLCSdkType.TESTBOX, // Change to LIVE for production
        store_id: "craft688303963ee3c", // Replace with your Store ID
        store_passwd: "craft688303963ee3c@ssl", // Replace with your Password
        total_amount: totalAmount,
        tran_id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      ),
    );

    try {
      final response = await sslcommerz.payNow();
      log("SSLCommerz Response: ${jsonEncode(response)}");

      if (response.status == 'VALID') {
        ToastMeesage.showToastMessage(context, "✅ Payment Successful!");
        Navigator.pop(context, true);
      } else if (response.status == 'Closed') {
        ToastMeesage.showToastMessage(context, "⚠ Payment Closed.");
      } else if (response.status == 'FAILED') {
        ToastMeesage.showToastMessage(context, "❌ Payment Failed.");
      } else {
        ToastMeesage.showToastMessage(
          context,
          "Unknown Status: ${response.status}",
        );
      }
    } catch (e) {
      log("SSLCommerz Exception: $e");
      ToastMeesage.showToastMessage(context, "Payment Error Occurred!");
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = calculateTotalAmount();

    return Scaffold(
      appBar: AppBar(title: const Text("SSLCommerz Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                sslCommerz(context);
              },
              child: Text("Pay  ${totalAmount.toStringAsFixed(2)} via SSL"),
            ),
          ),
        ),
      ),
    );
  }
}
