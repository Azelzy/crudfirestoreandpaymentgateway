import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/button_widget.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SHOPPING CART"),
        toolbarHeight: isTablet ? 80 : 60,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isTablet ? 16 : 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEB8D9F),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Text(
                  'YOUR ITEMS',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CartItem(
                        title: "FAST FOOD",
                        subtitle: "French Fries",
                        price: 12000,
                      ),
                      SizedBox(height: isTablet ? 16 : 12),
                      const CartItem(
                        title: "BURGER",
                        subtitle: "Cheese Burger",
                        price: 25000,
                      ),
                      SizedBox(height: isTablet ? 16 : 12),
                      const CartItem(
                        title: "FAST FOOD",
                        subtitle: "Fried Chicken",
                        price: 18000,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isTablet ? 20 : 16),
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
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      'Rp 55000',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: isTablet ? 20 : 16),

              AppButton(
                text: 'PURCHASE NOW',
                onPressed: () async {
                  final result = await Get.toNamed(AppRoutes.paymentpage);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF9B97D1),
                        content: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Text(
                            'Payment Status: ${result ?? "CANCELLED"}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}