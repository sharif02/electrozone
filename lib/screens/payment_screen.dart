import 'dart:convert';
import 'dart:developer';
import 'package:electro_zone/widgets/toast_meesage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class PaymentScreen extends StatelessWidget {
  final List products;

  const PaymentScreen({super.key, required this.products});

  Future<void> sslCommerz(BuildContext context) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "E-commerce Product",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "craft688303963ee3c",
        store_passwd: "craft688303963ee3c@ssl",
        total_amount: 21,
        tran_id: "TRLXT980701",
      ),
    );
    final response = await sslcommerz.payNow();
    if (response.status == 'VALID') {
      log(jsonEncode(response));
      log("Payment Completed SSL:  ${response.tranId}");
      log(response.tranDate ?? '');

      Navigator.pop(context, true);
    }
    if (response.status == 'Closed') {
      log("Payment ssl Closed");
      ToastMeesage.showToastMessage(context, "Payment Closed.");
    }
    if (response.status == "FAILED") {
      ToastMeesage.showToastMessage(context, "Payment Failed.");
      log("Payment ssl failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SSlCommerz")),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              sslCommerz(context);
            },
            child: Text("Pay \$${20}} via SSL"),
          ),
        ),
      ),
    );
  }
}
