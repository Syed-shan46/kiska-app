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
      User user = User(
        id: '',
        userName: userName,
        email: email,
        password: password,
      );
      http.Response response = await http.post(Uri.parse('$Uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
          });

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account Created Successfully');
        },
      );
    } catch (e) {}
  }
}
