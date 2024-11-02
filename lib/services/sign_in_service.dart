import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/navigation_menu.dart';

class SignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      // Check if the user is already signed in
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser != null) {
        Get.to(() => NavigationMenu());
        // User is already signed in, return user data
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        return googleAuth.idToken; // Or return any user data as needed
      }

      // If not signed in, prompt for sign-in
      final GoogleSignInAccount? newGoogleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await newGoogleUser!.authentication;

      // Send the ID token to the Node.js server
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/google/callback'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"id_token": "${googleAuth.idToken}"}',
      );

      if (response.statusCode == 200) {
        // Handle success (e.g., return user data or any required response)
        Get.to(() =>
            NavigationMenu()); // Return user data or any required response
      } else {
        // Handle errorˇ
        throw Exception('Failed to sign in:  ${response.body}');
      }
    } catch (error) {
      throw Exception('Sign-in failed: $error');
      print(error);
    }
    return null;
  }
}
