import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/button_widget.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/cart_widget.dart';
import 'package:crudfirestoreandpaymentgateway/utils/snackbar_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: isTablet
          ? null
          : AppBar(title: const Text("SHOPPING CART"), toolbarHeight: 60),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: ListView(
          padding: EdgeInsets.all(isTablet ? 32 : 16),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 20 : 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEB8D9F),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Text(
                'YOUR ITEMS',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 24 : 16),
            
            const CartItem(
              title: "FAST FOOD",
              subtitle: "French Fries",
              price: 12000,
            ),
            SizedBox(height: isTablet ? 20 : 12),
            const CartItem(
              title: "BURGER",
              subtitle: "Cheese Burger",
              price: 25000,
            ),
            SizedBox(height: isTablet ? 20 : 12),
            const CartItem(
              title: "FAST FOOD",
              subtitle: "Fried Chicken",
              price: 18000,
            ),

            SizedBox(height: isTablet ? 32 : 16),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              decoration: BoxDecoration(
                color: const Color(0xFFBDDAF0),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:',
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    'Rp 55000',
                    style: TextStyle(
                      fontSize: isTablet ? 32 : 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 24 : 16),

            AppButton(
              text: 'PURCHASE NOW',
              onPressed: () async {
                try {
                  // Navigate to payment
                  final result = await Get.toNamed(AppRoutes.paymentpage);

                  // Handle payment result
                  if (result != null) {
                    if (result == 'success' || result == 'settlement') {
                      SnackbarHelper.showSuccess(
                        'Payment completed successfully!',
                      );
                    } else if (result == 'pending') {
                      SnackbarHelper.showInfo('Payment is pending...');
                    } else if (result == 'cancel' || result == 'expire') {
                      SnackbarHelper.showError('Payment was cancelled');
                    } else {
                      SnackbarHelper.showError('Payment status: $result');
                    }
                  } else {
                    SnackbarHelper.showInfo('Payment was cancelled');
                  }
                } catch (e) {
                  SnackbarHelper.showError(
                    'Error processing payment: ${e.toString()}',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}