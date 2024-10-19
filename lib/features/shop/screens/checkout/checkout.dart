import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/models/address_model.dart';
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
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _fetchedAddress == null
                ? Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('No address found.',
                        style: TextStyle(color: Colors.red)),
                  )
                : Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Name: ${_fetchedAddress!.name}'),
                        Text('Phone: ${_fetchedAddress!.phone}'),
                        Text('Country: ${_fetchedAddress!.country}'),
                        Text('City: ${_fetchedAddress!.city}'),
                        Text('Address: ${_fetchedAddress!.address}'),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
