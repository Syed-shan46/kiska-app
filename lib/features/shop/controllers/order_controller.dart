import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/services/http_response.dart';

class OrderController {
  createOrders({
    required final String id,
    required final String name,
    required final String phone,
    required final String country,
    required final String city,
    required final String address,
    required final String productName,
    required final int quantity,
    required final String category,
    required final String image,
    required final int totalAmount,
    required final String paymentStatus,
    required final bool delivered,
    required context,
  }) async {
    try {
      final Order order = Order(
        id: id,
        phone: phone,
        country: country,
        city: city,
        address: address,
        name: name,
        productName: productName,
        quantity: quantity,
        category: category,
        image: image,
        totalAmount: totalAmount,
        paymentStatus: paymentStatus,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your have placed an order');
          });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
