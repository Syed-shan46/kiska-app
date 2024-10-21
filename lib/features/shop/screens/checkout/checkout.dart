import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final AddressController addressController = AddressController();
  Address? _fetchedAddress; // To hold the fetched address

  // Fetch address
  Future<void> fetchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      Address? address = await addressController.fetchAddressByUserId(userId);
      setState(() {
        _fetchedAddress = address;
      });
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
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Deliver to text
              Text(
                'Deliver to',
                style: TextStyle(
                  fontSize: 15,
                  color: ThemeUtils.dynamicTextColor(context),
                ),
              ),
              const SizedBox(height: 5),

              // Address container
              _fetchedAddress == null
                  ? Container(
                      
                      child: const Text(''),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Address details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${_fetchedAddress!.name}'),
                                Text('Phone: ${_fetchedAddress!.phone}'),
                                Text('Address: ${_fetchedAddress!.address}'),
                              ],
                            ),
                          ),
                          // Change button
                          TextButton(
                            onPressed: () {
                              // Handle change address action
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: ThemeUtils.dynamicTextColor(context),
                              foregroundColor: DynamicBg.sameBrightness(context),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            ),
                            child: const Text('Change'),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
