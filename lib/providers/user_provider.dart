import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiska/features/authentication/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(User(
          id: '',
          userName: '',
          email: '',
          password: '',
          token: ''
        ));
  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  // Method to clear user state
  void signOut() {
    state = null;
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
