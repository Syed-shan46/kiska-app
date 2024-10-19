// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final String country;
  final String city;
  final String address;

  Address({
    required this.userId,
    required this.id,
    required this.name,
    required this.phone,
    required this.country,
    required this.city,
    required this.address,
  });

  // Convert the object to a Map (for JSON encoding)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'name': name,
      'phone': phone,
      'country': country,
      'city': city,
      'address': address,
    };
  }

  // Create an instance of Address from a JSON Map
  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
      id: map['_id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      userId: map['userId'] as String, // Add userId here
    );
  }

  // Convert the Address object to a JSON string
  String toJson() => json.encode(toMap());
}
