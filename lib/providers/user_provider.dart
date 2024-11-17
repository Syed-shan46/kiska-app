import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/authentication/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null); // Initialize with null for no user state

  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
    print('User state updated: ${state?.email}');
  }

  void signOut() {
    state = null;
    print('User signed out');
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
