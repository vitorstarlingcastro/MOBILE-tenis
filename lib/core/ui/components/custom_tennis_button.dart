import 'package:flutter/material.dart';

class CustomTennisButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  
  const CustomTennisButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Nós retornamos um botão que herda seu visual COMPLETAMENTE
    // do nosso arquivo pai app_theme.dart. Nenhuma cor é escrita aqui.
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
