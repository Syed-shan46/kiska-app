import 'dart:convert';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/services/http_response.dart';

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
      http.Response response = await http.post(
          Uri.parse('http://10.0.2.2:3000/api/signup'),
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
        onSuccess: () {
          showSnackBar(context, 'Account Created Successfully');
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
        Uri.parse('http://10.0.2.2:3000/api/signin'),
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
          onSuccess: () {
            Get.to(() => NavigationMenu());
          });
    } catch (e) {}
  }
}


