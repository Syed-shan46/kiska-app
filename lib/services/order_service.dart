import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kiska/features/authentication/global_varaibles.dart';

class OrderService {
  // Replace with your backend URL
  static  final String _baseUrl = '$uri/api/place-order';

  Future<void> sendOrderDetailsToAdmin({
    required String orderId,
    required List<Map<String, dynamic>> products,
    required int totalAmount,
    required String userEmail,
  }) async {
    final url = Uri.parse(_baseUrl);

    // Create the order details payload
    final orderDetails = {
      'orderId': orderId,
      'products': products,
      'totalAmount': totalAmount,
      'userEmail': userEmail,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderDetails),
      );

      if (response.statusCode == 200) {
        print('Order email sent successfully');
      } else {
        print('Failed to send order email: ${response.body}');
      }
    } catch (error) {
      print('Error sending order email: $error');
    }
  }
}
