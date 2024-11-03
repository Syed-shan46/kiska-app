import 'dart:convert';

import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/services/http_response.dart';

class AddressController {
  uploadAddress({
    required String name,
    required String phone,
    required String country,
    required String city,
    required String address,
    required String userId,
    required String pin,
    required String state,
    required context,
  }) async {
    try {
      Address addressModel = Address(
          userId: userId,
          id: 'id',
          name: name,
          phone: phone,
          country: country,
          city: city,
          state: state,
          pin: pin,
          address: address);

      http.Response response = await http.post(
          Uri.parse('$uri/api/add-address'),
          body: addressModel.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      manageHttpResponse(
          response: response, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, 'Error$e');
    }
  }

  Future<Address?> fetchAddressByUserId(String userId) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/get-address/$userId"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      // update address by Id

      if (response.statusCode == 200) {
        jsonDecode(response.body);
        return Address.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      return null;
    }
  }

  // Update address by user ID
  Future<bool> updateAddress(String userId, Address updateAddress) async {
    try {
      final response = await http.put(
        Uri.parse('$uri/api/update-address/$userId'),
        body: jsonEncode(updateAddress.toMap()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error updating address: $e");
      return false;
    }
  }
}
