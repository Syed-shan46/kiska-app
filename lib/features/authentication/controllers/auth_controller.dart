import 'package:kiska/features/authentication/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/services.dart/http_response.dart';

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
}
