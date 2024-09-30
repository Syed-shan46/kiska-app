
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/widgets/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/authentication/login/widgets/divider.dart';
import 'package:kiska/features/authentication/login/widgets/social_icons.dart';
import 'package:kiska/utils/constants/sizes.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

 

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
                child: Column(
                  children: [
                    const Row(
                      children: [
                        /// first name
                        Expanded(
                          child: MyTextField(
                            labelText: 'First Name',
                            icon: Iconsax.user,
                          ),
                        ),

                        /// Last name
                        SizedBox(width: MySizes.spaceBtwInputFields),
                        Expanded(
                          child: MyTextField(
                            labelText: 'Last Name',
                            icon: Iconsax.user,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Username
                    MyTextField(
                      controller: usernameController,
                      labelText: 'Username',
                      icon: Iconsax.user,
                    ),

                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Email
                    MyTextField(
                      controller: emailController,
                      labelText: 'Email',
                      icon: Iconsax.user_edit,
                    ),
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// phone number
                    const MyTextField(
                      labelText: 'Username',
                      icon: Iconsax.call,
                    ),
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// password
                    MyTextField(
                      controller: passWordController,
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
                              value: true,
                              checkColor: Colors.white,
                              onChanged: (value) {}),
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
                  onPressed: () {
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
