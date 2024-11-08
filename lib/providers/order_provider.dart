import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/models/order_model.dart';

class OrderProvider extends StateNotifier<List<Order>> {
  OrderProvider() : super([]);
  // Reset the orders to an empty list
  void resetOrders() {
    state = [];
  }

  void setOrders(List<Order> orders) {
    state = orders;
  }

  
}

final orderProvider = StateNotifierProvider<OrderProvider, List<Order>>((ref) {
  return OrderProvider();
});
