import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kiska/navigation_menu.dart';

// Initialize Google Sign-In
final GoogleSignIn _googleSignIn = GoogleSignIn();
GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

// Function to handle Google Sign-In and send ID token to the backend
Future<void> signInWithGoogle() async {
  try {
    print("Attempting to sign in with Google...");

    // Step 1: Trigger Google Sign-In flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Check if sign-in was canceled
    if (googleUser == null) {
      print("Google sign-in was canceled.");
      return; // The user canceled the sign-in
    }

    print("User signed in: ${googleUser.email}");

    // Step 2: Obtain authentication details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Step 3: Get the ID token
    final String? idToken = googleAuth.idToken;
    print("ID Token: $idToken");

    // Step 4: Send ID token to your backend for verification
    if (idToken != null) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'token': idToken, // Use idToken directly
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // On successful authentication, navigate to NavigationMenu
        Get.offAll(() => NavigationMenu());
      } else {
        print('Failed to authenticate: ${response.body}');
      }
    } else {
      print('ID Token is null.');
    }
  } catch (error) {
    print('Google Sign-In error: $error');
  }
}
