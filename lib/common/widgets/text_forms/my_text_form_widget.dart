import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.labelText,
    this.icon,
    this.showSuffixIcon = false,
    this.controller,
  });

  final String labelText;
  final IconData? icon;
  final bool showSuffixIcon;
  final TextEditingController? controller;

  @override
  build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: showSuffixIcon ? const Icon(Iconsax.eye_slash) : null,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          labelText: labelText,
          labelStyle:
              TextStyle(color: Theme.of(context).colorScheme.primaryFixed)),
    );
  }
}
