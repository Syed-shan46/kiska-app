import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:kiska/features/shop/screens/address/address.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllAddress extends ConsumerStatefulWidget {
  const AllAddress({super.key});

  @override
  _AllAddressState createState() => _AllAddressState();
}

class _AllAddressState extends ConsumerState<AllAddress> {
  // Address Fetching
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
        actions: [
          IconButton(
              onPressed: () => Get.to(() => AddressScreen()),
              icon: Icon(Icons.add))
        ],
        title: Text('All Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: MySizes.spaceBtwItems),
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
