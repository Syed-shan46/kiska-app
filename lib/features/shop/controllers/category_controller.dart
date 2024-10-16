import 'dart:convert';
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  // Fetch categories
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('Failed to Load Categories');
      }
    } catch (e) {
      throw Exception('Error loading Categories $e');
    }
  }
}
