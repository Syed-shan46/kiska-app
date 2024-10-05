import 'dart:convert'; // This library provides functionality to work with JSON data.

// This class represents a user with basic attributes like id, username, email, and password.
class User {
  // Final variables for each user attribute (cannot be changed once set).
  final String id;
  final String userName;
  final String email;
  final String password;

  // Constructor to create a User object. All fields are required.
  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  // Converts the User object to a Map (key-value pairs), which can easily be transformed into JSON.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // Mapping each field to a key-value pair (JSON format).
      "id": id, // 'id' key will hold the user id.
      "userName": userName, // 'userName' key will hold the username.
      "email": email, // 'email' key will hold the user's email.
      "password": password, // 'password' key will hold the user's password.
    };
  }

  // Encodes the Map (created above) into a JSON string.
  String toJson() => json.encode(toMap());

  // Factory method that creates a User object from a Map (which is usually converted from JSON).
  // 'factory' means it doesn't always return the same instance but creates new instances as needed.
  factory User.fromMap(Map<String, dynamic> map) {
    // Safely extract data from the map using  Gkeys.
    // If the key is not found or the value is null, it defaults to an empty string.
    return User(
        id: map['_id'] as String? ?? "", // '_id' is typically used in databases like MongoDB.
        userName: map['userName'] as String? ?? "", // Extract 'userName' from the map.
        email: map['email'] as String? ?? "", // Extract 'email' from the map.
        password: map['password'] as String? ?? ""); // Extract 'password' from the map.
  }

  // This method converts a JSON string (received from an API or other sources) into a User object.
  // It decodes the JSON string into a map and then passes it to `fromMap` to create the User.
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
