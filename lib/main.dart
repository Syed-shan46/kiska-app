import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiska/features/authentication/login/login.dart';
import 'package:kiska/navigation_menu.dart';
import 'package:kiska/utils/themes/dark_theme.dart';
import 'package:kiska/utils/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home:  LoginScreen(),
      
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Column(
          children: [
            Text('Settings page'),
          ],
        ),
      ),
    );
  }
}

// HomeScreen
