import 'dart:convert';

import 'package:get/get.dart';
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/features/shop/screens/orders/success_screen.dart';
import 'package:kiska/services/http_response.dart';

class OrderController {
  createOrders({
    required final String id,
    required final String name,
    required final String phone,
    required final String country,
    required final String city,
    required final String address,
    required final String state,
    required final String pin,
    required final String productName,
    required final int quantity,
    required final String category,
    required final String image,
    required final int totalAmount,
    required final String paymentStatus,
    required final String orderStatus,
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
        pin: pin,
        state: state,
        name: name,
        productName: productName,
        quantity: quantity,
        category: category,
        image: image,
        totalAmount: totalAmount,
        paymentStatus: paymentStatus,
        orderStatus: orderStatus,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your have placed an order');
          });

      Get.to(() => SuccessScreen());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> loadOrders({required String userId}) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/orders/$userId'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading orders: $e'); // Logs detailed error
      throw Exception('Error loading orders: $e');
    }
  }
}
