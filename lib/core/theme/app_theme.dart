import 'package:flutter/material.dart';

class AppTheme {
  // === PALETA DE CORES CENTRAL (Design System) ===
  // Se quiser mudar a cor primária do app no futuro, mude apenas AQUI!
  static const Color primaryColor = Color(0xFF00C853); // Verde neon 
  static const Color backgroundDark = Color(0xFF121212); // Tema escuro profundo
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color textWhite = Color(0xFFE0E0E0);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color errorRed = Color(0xFFCF6679);

  // === ESPAÇAMENTOS PADRÕES (Design System) ===
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double circularRadius = 12.0;

  // === THEME DATA GLOBAL ===
  // O aplicativo vai olhar para este construtor para pintar todas as telas automaticamente.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryColor,
      
      // Estilo global dos Textos
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textWhite, fontSize: 32, fontWeight: FontWeight.w900),
        titleLarge: TextStyle(color: textWhite, fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: textWhite, fontSize: 16),
        bodyMedium: TextStyle(color: textGrey, fontSize: 14),
      ),
      
      // Estilo global dos Botões Elevados Primários
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundDark,
          padding: const EdgeInsets.symmetric(vertical: spacingMedium, horizontal: spacingLarge),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      
      // Estilo global de caixas de entrada de texto (Inputs e Formulários)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularRadius),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularRadius),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        labelStyle: const TextStyle(color: textGrey),
      ),
    );
  }
}
