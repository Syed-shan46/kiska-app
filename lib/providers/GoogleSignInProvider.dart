import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> googleLogin(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return; // If the user cancels login
      _user = googleUser;

      // Perform any other login success actions (like API calls)

      // On successful sign-in, navigate to the NavigationMenu screen
       // Using GetX for navigation
      // OR use this if you're using Flutter's Navigator
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
    } catch (e) {
      print("Google Sign-In Error: $e");
      // Handle the error, e.g., show a snackbar or dialog
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }
}
