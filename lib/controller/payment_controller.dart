import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/payment_service.dart';

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
        throw Exception('redirect_url kosong dari backend');
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
                Get.back(result: status);
                return NavigationDecision.prevent;
              }

              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(redirectUrl));

      web.value = controller;
    } catch (e) {
      statusMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }
}
