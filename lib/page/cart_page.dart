import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/button_widget.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CartItem(
              title: "Fast Food",
              subtitle: "French Fries",
              price: 12000,
            ),
            const CartItem(
              title: "Burger",
              subtitle: "Cheese Burger",
              price: 25000,
            ),
            const CartItem(
              title: "Fast Food",
              subtitle: "Fried Chicken",
              price: 18000,
            ),

            const Spacer(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total: Rp 55000",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),

            AppButton(
              text: 'Purchase Now',
              onPressed: () async {
                final result = await Get.toNamed(AppRoutes.paymentpage);

                Get.snackbar('Payment', 'Status: ${result ?? "-"}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
