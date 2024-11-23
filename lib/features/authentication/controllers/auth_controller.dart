import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/features/authentication/screens/login/login.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/providers/order_provider.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/services/http_response.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUPUsers({
    required context,
    required userName,
    required email,
    required password,
  }) async {
    try {
      print('Attempting to create user with email: $email');

      // Create user object
      User user = User(
        id: '',
        userName: userName,
        email: email,
        password: password,
        token: '',
      );

      // Make http request
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
          });

      // Log response details for debugging
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check and log the response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          Get.snackbar('Account', 'Account Created Successfully',icon: Icon(Icons.person));
          await Future.delayed(Duration(seconds: 3));
          Get.to(() => LoginScreen());
        },
      );
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> signInUsers({
  required BuildContext context,
  required WidgetRef ref,
  required String email,
  required String password,
}) async {
  try {
    http.Response response = await http.post(
      Uri.parse('$uri/api/signin'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Debugging lines
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String token = jsonDecode(response.body)['token'];
      await preferences.setString('auth_token', token);

      // Extract user data from response
      final userJson = jsonEncode(jsonDecode(response.body)['user']);

      // Update the user state using ref
      ref.read(userProvider.notifier).setUser(userJson);

      // Save user data in SharedPreferences
      await preferences.setString('user', userJson);

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: Colors.white,
              size: 30,
            ),
          );
        },
      );

      // Wait for 1 second
      await Future.delayed(Duration(seconds: 1));
      // Close loading indicator
      Navigator.pop(context);

      // Display success message
      Get.snackbar('Login successFully', 'Your are Logged in',icon: Icon(Icons.person));
      await Future.delayed(Duration(seconds: 1));

      // Navigate to Navigation Menu
      Get.offAll(() => NavigationMenu());
    } else {
      Get.snackbar('Login Failed',jsonDecode(response.body)['msg'],);
    }
  } catch (e) {
    showSnackBar(context, 'Error signing in: $e');
  }
}

  
Future<void> signOutUser({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Clear the token and user data from SharedPreferences
    await preferences.remove('auth_token');
    await preferences.remove('user');

    // Reset the user and order states
    ref.read(userProvider.notifier).signOut();
    ref.read(orderProvider.notifier).resetOrders();

    // Navigate to LoginScreen and clear navigation stack
    Get.offAll(() => LoginScreen());

    // Show success message
    Get.snackbar('Logout', 'Logout Successfully',icon: Icon(Icons.logout));
  } catch (e) {
    // Show error message in case of any issues
    showSnackBar(context, 'Error signing out: $e');
  }
}

}
