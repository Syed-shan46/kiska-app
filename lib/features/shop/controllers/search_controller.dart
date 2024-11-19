import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'dart:convert';

import 'package:kiska/features/shop/models/product_model.dart';
import 'package:kiska/features/shop/screens/search/search.dart';

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isEmpty) {
    return []; // Return an empty list if no query
  }

  final response = await http.get(Uri.parse('$uri/api/search?query=$searchQuery'));

  if (response.statusCode == 200) {
    // Decode response
    final decodedBody = jsonDecode(response.body);
    final data = decodedBody['data'] as List<dynamic>;

    // Map each JSON object in 'data' to a Product
    return data.map((product) => Product.fromMap(product as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});
