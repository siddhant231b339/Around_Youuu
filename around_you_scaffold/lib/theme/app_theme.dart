import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeBundle {
  final ThemeData light;
  final ThemeData dark;
  AppThemeBundle({required this.light, required this.dark});
}

final appThemeProvider = Provider<AppThemeBundle>((ref) {
  final vibrantDark = _buildDarkTheme();
  final vibrantLight = _buildLightTheme();
  return AppThemeBundle(light: vibrantLight, dark: vibrantDark);
});

ColorScheme _vibrantLightScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6C5CE7),
    onPrimary: Colors.white,
    secondary: Color(0xFF00E5FF),
    onSecondary: Colors.black,
    tertiary: Color(0xFFFF6B6B),
    onTertiary: Colors.white,
    error: Color(0xFFFF3B30),
    onError: Colors.white,
    background: Color(0xFF0B0C1E),
    onBackground: Colors.white,
    surface: Color(0xFF12132A),
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF1A1C39),
    outline: Color(0xFF4E4F7A),
    outlineVariant: Color(0xFF2C2D4C),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFE6E7FF),
    onInverseSurface: Color(0xFF12132A),
    inversePrimary: Color(0xFFA39CFF),
  );
}

ColorScheme _vibrantDarkScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA39CFF),
    onPrimary: Color(0xFF0C0D20),
    secondary: Color(0xFF66F0FF),
    onSecondary: Color(0xFF0C0D20),
    tertiary: Color(0xFFFF8F8F),
    onTertiary: Color(0xFF0C0D20),
    error: Color(0xFFFF5C5C),
    onError: Color(0xFF0C0D20),
    background: Color(0xFF0B0C1E),
    onBackground: Colors.white,
    surface: Color(0xFF12132A),
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF1A1C39),
    outline: Color(0xFF5C5DA0),
    outlineVariant: Color(0xFF2F315C),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFE6E7FF),
    onInverseSurface: Color(0xFF12132A),
    inversePrimary: Color(0xFF6C5CE7),
  );
}

ThemeData _buildBaseTheme(ColorScheme scheme) {
  final textTheme = GoogleFonts.poppinsTextTheme().apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.tertiary,
      foregroundColor: scheme.onTertiary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceVariant,
      hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.6)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.secondary, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: scheme.surfaceVariant,
      labelStyle: TextStyle(color: scheme.onSurface),
      selectedColor: scheme.secondary,
      secondaryLabelStyle: TextStyle(color: scheme.onSecondary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: scheme.surface,
      selectedItemColor: scheme.secondary,
      unselectedItemColor: scheme.onSurface.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    cardTheme: CardTheme(
      color: scheme.surface,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: scheme.shadow.withOpacity(0.2),
    ),
    dividerTheme: DividerThemeData(color: scheme.outline.withOpacity(0.4)),
  );
}

ThemeData _buildLightTheme() => _buildBaseTheme(_vibrantLightScheme());
ThemeData _buildDarkTheme() => _buildBaseTheme(_vibrantDarkScheme());