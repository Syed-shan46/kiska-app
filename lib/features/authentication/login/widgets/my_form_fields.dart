
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/widgets/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/authentication/register/register.dart';
import 'package:kiska/features/shop/screens/home/home.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/themes/app_colors.dart';


class MyFormFields extends StatefulWidget {
  const MyFormFields({
    super.key,
  });

  @override
  State<MyFormFields> createState() => _MyFormFieldsState();
}

class _MyFormFieldsState extends State<MyFormFields> {
  /// Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Login method
  

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          /// Email TextField
          MyTextField(
              controller: emailController,
              labelText: 'Email',
              icon: Iconsax.direct_right),
          SizedBox(height: MySizes.spaceBtwItems),

          /// Password TextField
          MyTextField(
              controller: passwordController,
              labelText: 'Password',
              icon: Iconsax.password_check),
          SizedBox(height: MySizes.spaceBtwItems / 2),

          /// Remember me & Forgot Password
          const RememberMePassword(),
          const SizedBox(height: MySizes.spaceBtwSections),

          /// Sign in Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () => Get.to( NavigationMenu()),
              child: const Text(

                'Sign in',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwItems),

          /// Create account  Button
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
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed:() => Get.to(()=> SignUpScreen()),
        child: Text(
          'Create Account',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,),
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
              style: TextStyle(fontWeight: FontWeight.w400
                  ),
            )),
      ],
    );
  }
}