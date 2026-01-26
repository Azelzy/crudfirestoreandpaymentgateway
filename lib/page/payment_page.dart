import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/payment_controller.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Obx(() {
        final webController = controller.web.value;

        if (controller.isLoading.value || webController == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return WebViewWidget(controller: webController);
      }),
    );
  }
}
