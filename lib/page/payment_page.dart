import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/payment_controller.dart';

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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
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
}