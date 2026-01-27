import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/payment_controller.dart';
import '../utils/snackbar_helper.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYMENT'),
        toolbarHeight: isTablet ? 80 : 60,
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Show confirmation dialog before leaving payment page
              _showExitDialog(context);
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: Obx(() {
          final webController = controller.web.value;

          if (controller.isLoading.value || webController == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: isTablet ? 120 : 100,
                    height: isTablet ? 120 : 100,
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9B97D1),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 4,
                    ),
                  ),
                  SizedBox(height: isTablet ? 32 : 24),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24 : 16,
                      vertical: isTablet ? 12 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCDCB3),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Text(
                      'LOADING PAYMENT...',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  if (controller.statusMessage.value.isNotEmpty) ...[
                    SizedBox(height: isTablet ? 24 : 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEB8D9F),
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 40,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              controller.statusMessage.value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9B97D1),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    controller.retryPayment();
                                  },
                                  child: const Center(
                                    child: Text(
                                      'RETRY',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: WebViewWidget(controller: webController),
          );
        }),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFF2D6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        title: const Text(
          'CANCEL PAYMENT?',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: const Text(
          'Are you sure you want to cancel this payment? Your order will not be processed.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEB8D9F),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Get.back(); // Go back to cart
                SnackbarHelper.showInfo('Payment cancelled');
              },
              child: const Text(
                'CANCEL PAYMENT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}