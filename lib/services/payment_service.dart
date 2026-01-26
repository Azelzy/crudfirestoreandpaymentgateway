import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>> createTransaction({
    required String orderId,
    required int grossAmount,
    required String firstName,
    required String email,
  }) async {
    final uri = Uri.parse('$baseUrl/create-transaction');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'order_id': orderId,
        'gross_amount': grossAmount,
        'first_name': firstName,
        'email': email,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(
        'Create transaction gagal: ${res.statusCode} ${res.body}',
      );
    }

    final data = jsonDecode(res.body);

    final redirectUrl = (data['redirect_url'] ?? '').toString();
    if (redirectUrl.isEmpty) {
      throw Exception('redirect_url kosong dari backend: ${res.body}');
    }

    return data;
  }
}
