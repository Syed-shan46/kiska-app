import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/services/sign_in_service.dart';
import 'package:kiska/utils/constants/sizes.dart';

class MySocialIcons extends StatefulWidget {
  MySocialIcons({super.key});

  @override
  State<MySocialIcons> createState() => _MySocialIconsState();
}

class _MySocialIconsState extends State<MySocialIcons> {
  final SignInService _signInService = SignInService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(BuildContext context) async {
    print("Sign-in button clicked"); // Debugging line
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print(
          "Google user signed in: ${googleUser?.displayName}"); // Print user info

      if (googleUser == null) {
        print("User canceled the sign-in");
        return; // The user canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("ID Token: ${googleAuth.idToken}"); // Print the ID token

      // Attempt to sign in with Google
      final userData = await _signInService.signInWithGoogle();
      // If user data is not null, navigate to NavigationMenu
      if (userData != null) {
        Get.to(() => NavigationMenu());
      }
    } catch (error) {
      print(error);
      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => _handleSignIn(context),
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/google-icon.png')),
          ),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        // facebook
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/facebook-icon.png')),
          ),
        ),
      ],
    );
  }
}
