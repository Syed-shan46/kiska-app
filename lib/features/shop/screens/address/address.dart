import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/screens/checkout/checkout.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/text_theme.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AddressController addressController = AddressController();

  // Controllers to capture input values
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

// To hold the fetched address

  // Variables to manage button state and animation
  bool isAdded = false;

  Future<void> submitAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    // Submit address
    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      setState(() {
        isAdded = true;
      });

      try {
        addressController.uploadAddress(
          userId: userId,
          name: nameController.text,
          phone: phoneController.text,
          country: countryController.text,
          city: cityController.text,
          address: addController.text,
          pin: pinController.text,
          state: stateController.text,
          context: context,
        );

        await Future.delayed(Duration(seconds: 2));

        // Clear all input fields after successful submission
        nameController.clear();
        phoneController.clear();
        countryController.clear();
        cityController.clear();
        addController.clear();
        pinController.clear();
        stateController.clear();

        Get.to(() => CheckoutScreen());
      } catch (e) {
        print('Error$e');
      } finally {
        setState(() {
          isAdded = false;
        });
      }
    } else {
      print('User is not logged in ');
    }
  }

  // Fetch address
  Future<void> fetchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];
     // Address? address = await addressController.fetchAddressByUserId(userId);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                // Name
                MyTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  controller: nameController,
                  labelText: 'Name',
                  icon: Iconsax.user,
                ),
                SizedBox(height: 10),
                // Phone
                MyTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  controller: phoneController,
                  labelText: 'Phone',
                  icon: Icons.phone,
                ),
                SizedBox(height: 10),
                // Country and state
                Row(
                  children: [
                    Expanded(
                        child: MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      controller: countryController,
                      labelText: 'Country',
                      icon: Iconsax.building,
                    )),
                    SizedBox(width: 10),
                    // State
                    Expanded(
                        child: MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your State';
                        }
                        return null;
                      },
                      controller: stateController,
                      labelText: 'State',
                      icon: Iconsax.building,
                    )),
                   
                  ],
                ),
                SizedBox(height: 10),
                // City and pin
                Row(
                  children: [
                     Expanded(
                        child: MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      controller: cityController,
                      labelText: 'City',
                      icon: Iconsax.location_slash,
                    )),
                    SizedBox(width: 10),

                    // Pin code
                    Expanded(
                        child: MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Pin';
                        }
                        return null;
                      },
                      controller: pinController,
                      labelText: 'Pin Code',
                      icon: Iconsax.location_slash,
                    )),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  controller: addController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ThemeUtils.dynamicTextColor(context)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'Address',
                      prefixIcon: Icon(Iconsax.house)),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          isAdded = false;
                        });
                        submitAddress(); // Call the function that handles address submission
                      } else {
                        print('Please enter all input fields');
                      }
                    },
                    child: isAdded
                        ? LoadingAnimationWidget.flickr(
                            leftDotColor: DynamicBg.sameBrightness(context),
                            rightDotColor: AppColors.primaryColor,
                            size: 25)
                        : Text('Create',
                            style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: DynamicBg.sameBrightness(context))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
