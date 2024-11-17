import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/authentication/controllers/auth_controller.dart';
import 'package:kiska/features/authentication/screens/register/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';

class MyFormFields extends ConsumerStatefulWidget {
  const MyFormFields({
    super.key,
  });

  @override
  ConsumerState<MyFormFields> createState() => _MyFormFieldsState();
}

class _MyFormFieldsState extends ConsumerState<MyFormFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;

  loginUser() async {
    await _authController
        .signInUsers(context: context, email: email, password: password,ref: ref)
        .whenComplete(() {});
  }

  /// Login method

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email TextField
          MyTextField(
              onChanged: (value) {
                email = value;
              },
              // Validating
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              labelText: 'Email',
              icon: Iconsax.direct_right),
          SizedBox(height: MySizes.spaceBtwItems),

          // Password TextField
          MyTextField(
              onChanged: (value) {
                password = value;
              },
              labelText: 'Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your Password';
                }
                return null;
              },
              icon: Iconsax.password_check),
          SizedBox(height: MySizes.spaceBtwItems / 2),

          // Remember me & Forgot Password
          const RememberMePassword(),
          const SizedBox(height: MySizes.spaceBtwSections),

          // Sign in Button
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('Form is valid');
                  loginUser();
                }
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: DynamicBg.sameBrightness(context),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwItems),

          // Create account  Button
          CreateAccount(),
        ],
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: ThemeUtils.dynamicTextColor(context).withOpacity(0.8)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        onPressed: () => Get.to(() => SignUpScreen()),
        child: Text(
          'Create Account',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class RememberMePassword extends StatelessWidget {
  const RememberMePassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Remember me
        Row(
          children: [
            Checkbox(
                value: true,
                onChanged: (value) {},
                activeColor: AppColors.primaryColor,
                checkColor: Colors.white),
            const Text('Remember me?')
          ],
        ),

        /// Forgot password
        TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password',
              style: TextStyle(fontWeight: FontWeight.w400),
            )),
      ],
    );
  }
}
