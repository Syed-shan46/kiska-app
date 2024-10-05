import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/widgets/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/authentication/controllers/auth_controller.dart';
import 'package:kiska/features/authentication/screens/login/widgets/divider.dart';
import 'package:kiska/features/authentication/screens/login/widgets/social_icons.dart';
import 'package:kiska/utils/constants/sizes.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  bool _agreeToTerms = false;
  late String userName;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text("Let's create your account",
                  style: Theme.of(context).textTheme.headlineMedium),

              const SizedBox(height: MySizes.spaceBtwSections),

              /// form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Username
                    MyTextField(
                      onChanged: (value) {
                        userName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      labelText: 'Username',
                      icon: Iconsax.user,
                    ),

                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Email
                    MyTextField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      icon: Iconsax.user_edit,
                    ),
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// password
                    MyTextField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }

                        // Custom password validation to ensure it contains at least one number, one uppercase, and one lowercase letter
                        RegExp regex =
                            RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])');
                        if (!regex.hasMatch(value)) {
                          return 'Password must contain at least one number, one uppercase';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      icon: Iconsax.password_check,
                      showSuffixIcon: true,
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    /// Terms and  Conditions Checkbox
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            activeColor: Colors.blue,
                            value: _agreeToTerms,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: MySizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'I agree to',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: 'Privacy policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                    ),
                              ),
                              TextSpan(
                                  text: '&',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: 'Terms of Use',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// sign up button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_agreeToTerms) {
                        // Perform signup
                        print('Email: $email');
                        // Call your signup logic using _authController
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You must agree to the terms.'),
                          ),
                        );
                      }
                      await _authController.signUPUsers(
                          context: context,
                          userName: userName,
                          email: email,
                          password: password);
                    }
                  },
                  child: Text('Create Account',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryFixed,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// divider
              const MyDivider(dividerText: 'or sign in with'),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// social buttons
              const MySocialIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
