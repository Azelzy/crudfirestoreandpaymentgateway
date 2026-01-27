import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/payment_service.dart';
import '../utils/snackbar_helper.dart';

class PaymentController extends GetxController {
  final PaymentService _service = PaymentService();

  static const String finishUrlPrefix = 'https://example.com/midtrans-finish';

  final int grossAmount = 55000;
  final String firstName = 'Contoh';
  final String email = 'contoh@mail.com';

  final isLoading = true.obs;
  final statusMessage = ''.obs;
  final web = Rxn<WebViewController>();

  @override
  void onInit() {
    super.onInit();
    startPayment();
  }

  void startPayment() async {
    try {
      isLoading.value = true;

      final orderId = 'ORDER-${DateTime.now().millisecondsSinceEpoch}';
      final res = await _service.createTransaction(
        orderId: orderId,
        grossAmount: grossAmount,
        firstName: firstName,
        email: email,
      );

      final redirectUrl = (res['redirect_url'] ?? '').toString();
      if (redirectUrl.isEmpty) {
        throw Exception('Redirect URL is empty from backend');
      }

      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (req) {
              final url = req.url;

              if (url.startsWith(finishUrlPrefix)) {
                final uri = Uri.tryParse(url);
                final status =
                    uri?.queryParameters['transaction_status'] ?? 'unknown';
                
                if (status == 'success' || status == 'settlement') {
                  SnackbarHelper.showSuccess('Payment successful!');
                } else if (status == 'pending') {
                  SnackbarHelper.showInfo('Payment pending...');
                } else if (status == 'cancel' || status == 'expire') {
                  SnackbarHelper.showError('Payment cancelled or expired');
                } else {
                  SnackbarHelper.showError('Payment failed: $status');
                }
                
                Get.back(result: status);
                return NavigationDecision.prevent;
              }

              return NavigationDecision.navigate;
            },
            onPageStarted: (url) {
              // Optional: show loading indicator
            },
            onPageFinished: (url) {
              // Optional: hide loading indicator
            },
            onWebResourceError: (error) {
              SnackbarHelper.showError(
                'Page loading error: ${error.description}',
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(redirectUrl));

      web.value = controller;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      statusMessage.value = e.toString();
      
      String errorMessage = 'Failed to start payment';
      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Connection timeout. Please try again.';
      } else if (e.toString().contains('FormatException')) {
        errorMessage = 'Invalid response from server.';
      } else {
        errorMessage = 'Error: ${e.toString()}';
      }
      
      SnackbarHelper.showError(errorMessage);
      Get.back();
    }
  }

  void retryPayment() {
    startPayment();
  }
}