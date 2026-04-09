import 'package:flutter/material.dart';

class CustomTennisInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomTennisInput({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        // Todo o restante do background, fonte e cor da borda são puxados do app_theme.dart secretamente!
      ),
    );
  }
}
