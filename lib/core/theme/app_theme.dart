import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // =========================
  // 🌞 Light Theme
  // =========================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    primaryColor: AppColorsLight.primary,

    colorScheme: const ColorScheme.light(
      primary: AppColorsLight.primary,
      secondary: AppColorsLight.secondary,
      surface: AppColorsLight.surface,
      surfaceContainerHighest: AppColorsLight.grey100,
      onSurface: AppColorsLight.textPrimary,
      onSurfaceVariant: AppColorsLight.textSecondary,
    ),

    cardTheme: CardThemeData(
      color: AppColorsLight.card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsLight.background,
      elevation: 0,
      foregroundColor: AppColorsLight.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsLight.grey100,
      hintStyle: TextStyle(color: AppColorsLight.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorsLight.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorsLight.primary),
      ),
    ),

    dividerColor: AppColorsLight.divider,

    iconTheme: const IconThemeData(color: AppColorsLight.iconInactive),
    
    

    textTheme: TextTheme(
      bodyLarge: AppTextStyles.regular(16, color: AppColorsLight.textPrimary),
      bodyMedium: AppTextStyles.regular(
        14,
        color: AppColorsLight.textSecondary,
      ),
      bodySmall: AppTextStyles.regular(12, color: AppColorsLight.textDisabled),
    ),
  );

  // =========================
  // 🌙 Dark Theme
  // =========================
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    primaryColor: AppColorsDark.primary,

    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.secondary,
      surface: AppColorsDark.surface,
      surfaceContainerHighest: AppColorsDark.grey200,
      onSurface: AppColorsDark.textPrimary,
      onSurfaceVariant: AppColorsDark.textSecondary,
    ),

    cardTheme: CardThemeData(
      color: AppColorsDark.card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.background,
      elevation: 0,
      foregroundColor: AppColorsDark.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.grey200,
      hintStyle: TextStyle(color: AppColorsDark.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorsDark.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorsDark.primary),
      ),
    ),

    dividerColor: AppColorsDark.divider,

    iconTheme: const IconThemeData(color: AppColorsDark.iconInactive),

    textTheme: TextTheme(
      bodyLarge: AppTextStyles.regular(16, color: AppColorsDark.textPrimary),
      bodyMedium: AppTextStyles.regular(14, color: AppColorsDark.textSecondary),
      bodySmall: AppTextStyles.regular(12, color: AppColorsDark.textDisabled),
    ),
  );
}
