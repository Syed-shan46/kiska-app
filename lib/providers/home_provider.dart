import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/controllers/home_controller.dart';

// Define a provider for HomeController
final homeControllerProvider = Provider<HomeController>((ref) {
  return HomeController(); // Create a new instance of HomeController
});
