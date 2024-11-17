import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/onboarding/onboarding.dart';
import 'package:kiska/features/authentication/screens/login/login.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/providers/user_provider.dart';
import 'package:kiska/utils/themes/dark_theme.dart';
import 'package:kiska/utils/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: FutureBuilder(
            future: _checkTokenAndSetUser(ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              return OnboardingScreen();
            }),
      ),
    );
  }
}
