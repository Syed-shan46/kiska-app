import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/features/authentication/screens/login/login.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/services/http_response.dart';
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
          showSnackBar(context, 'Account Created Successfully');
          await Future.delayed(Duration(seconds: 3));
          Get.to(() => LoginScreen());
        },
      );
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> signInUsers(
      {required context,
      required String email,
      required String password}) async {
    print(
        'Sign-in called with email: $email and password: $password'); // Debugging line
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );
      // Add these print statements to inspect the API response
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            String token = jsonDecode(response.body)['token'];
            await preferences.setString('auth_token', token);

            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            providerContainer.read(userProvider.notifier).setUser(userJson);

            await preferences.setString('user', userJson);

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
            // Wait for 1 second
            await Future.delayed(Duration(seconds: 1));
            // Close the CircularProgressIndicator dialog
            Navigator.pop(context);
            await Future.delayed(Duration(seconds: 1));
            showSnackBar(context, 'You are Logged In');
            await Future.delayed(Duration(seconds: 2));
            Get.to(() => NavigationMenu());
          });
    } catch (e) {}
  }
}
