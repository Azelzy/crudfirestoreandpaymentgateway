import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:crudfirestoreandpaymentgateway/widgets/button_widget.dart';
import 'package:crudfirestoreandpaymentgateway/controller/cart_controller.dart';
import 'package:crudfirestoreandpaymentgateway/utils/snackbar_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    // Use Get.find to get CartController
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: isTablet
          ? null
          : AppBar(title: const Text("SHOPPING CART"), toolbarHeight: 60),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: Obx(() {
          // Check if cart is empty
          if (cartController.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDDAF0),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'YOUR CART\nIS EMPTY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
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
              
              // Cart Items List
              ...List.generate(
                cartController.cartItems.length,
                (index) {
                  final item = cartController.cartItems[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: isTablet ? 20 : 12,
                    ),
                    child: _buildCartItem(
                      item,
                      index,
                      isTablet,
                      cartController,
                    ),
                  );
                },
              ),

              SizedBox(height: isTablet ? 32 : 16),

              // Total Section
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
                      'Rp ${cartController.totalPrice}',
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
                        // Clear cart after successful payment
                        cartController.clearCart();
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
          );
        }),
      ),
    );
  }

  Widget _buildCartItem(
    CartItem item,
    int index,
    bool isTablet,
    CartController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCDCB3),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: isTablet
          ? _buildTabletLayout(item, index, controller)
          : _buildMobileLayout(item, index, controller),
    );
  }

  Widget _buildMobileLayout(
    CartItem item,
    int index,
    CartController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF9B97D1),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                'Rp ${item.totalPrice}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildQuantityButton(
              Icons.remove,
              () => controller.decreaseQuantity(index),
              false,
            ),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )),
            _buildQuantityButton(
              Icons.add,
              () => controller.increaseQuantity(index),
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
    CartItem item,
    int index,
    CartController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.subtitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildQuantityButton(
              Icons.remove,
              () => controller.decreaseQuantity(index),
              true,
            ),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )),
            _buildQuantityButton(
              Icons.add,
              () => controller.increaseQuantity(index),
              true,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF9B97D1),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Text(
            'Rp ${item.totalPrice}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap, bool isTablet) {
    return Container(
      width: isTablet ? 40 : 36,
      height: isTablet ? 40 : 36,
      decoration: BoxDecoration(
        color: const Color(0xFFBDDAF0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: isTablet ? 20 : 18, color: Colors.black),
        onPressed: onTap,
      ),
    );
  }
}