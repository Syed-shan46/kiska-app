import 'dart:convert';

import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      throw Exception('Error:$e');
    }
  }

  Future<List<Product>> loadProductsByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category/$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      throw Exception('Error:$e');
    }
  }
}
