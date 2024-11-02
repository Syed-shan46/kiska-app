import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/text_forms/my_text_form_widget.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:kiska/utils/themes/text_theme.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAddress extends ConsumerStatefulWidget {
  const EditAddress({super.key});

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends ConsumerState<EditAddress> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final AddressController addressController = AddressController();
  Address? fetchedAddress; // To hold the fetched address

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController addController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    phoneController = TextEditingController();
    countryController = TextEditingController();
    addController = TextEditingController();
    cityController = TextEditingController();
    fetchAddress();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    addController.dispose();
    super.dispose();
  }

  // Fetch address and populate fields
  Future<void> fetchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      Address? address = await addressController.fetchAddressByUserId(userId);
      setState(() {
        fetchedAddress = address;
        // Set controllers with fetched address data
        nameController.text = address?.name ?? '';
        phoneController.text = address?.phone ?? '';
        countryController.text = address?.country ?? '';
        cityController.text = address?.city ?? '';
        addController.text = address?.address ?? '';
      });
    }
  }

  Future<void> updateAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      // Create an updated Address object
      Address updateAddress = Address(
        userId: userId,
        id: '',
        name: nameController.text,
        phone: phoneController.text,
        country: countryController.text,
        city: cityController.text,
        address: addController.text,
      );

      await Future.delayed(Duration(seconds: 2));

      // Clear all input fields after successful submission

      // Update address and show feedback
      bool success =
          await addressController.updateAddress(userId, updateAddress);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Address updated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update address.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  labelText: 'Name',
                  icon: Iconsax.user,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  labelText: 'Phone',
                  icon: Icons.phone,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: MyTextField(
                      controller: countryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      labelText: 'Country',
                      icon: Iconsax.building,
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: MyTextField(
                      controller: cityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      labelText: 'City',
                      icon: Iconsax.location_slash,
                    )),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: addController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
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
                      updateAddress();
                    },
                    child: Text('Save changes',
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
