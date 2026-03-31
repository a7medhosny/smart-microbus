// import 'package:flutter/material.dart';
// import 'app_colors.dart';
// import 'app_text_styles.dart';

// class AppTheme {
//   // =========================
//   // 🌞 Light Theme
//   // =========================
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: AppColorsLight.background,
//     primaryColor: AppColorsLight.primary,

//     colorScheme: const ColorScheme.light(
//       primary: AppColorsLight.primary,
//       secondary: AppColorsLight.secondary,
//       surface: AppColorsLight.surface,
//       // surfaceContainerHighest: AppColorsLight.grey100,
//       onSurface: AppColorsLight.textPrimary,
//       onSurfaceVariant: AppColorsLight.textSecondary,
//     ),

//     cardTheme: CardThemeData(
//       color: AppColorsLight.card,
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     ),

//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColorsLight.background,
//       elevation: 0,
//       foregroundColor: AppColorsLight.textPrimary,
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: const TextStyle(
//         color: AppColorsLight.textSecondary,
//         fontSize: 14,
//       ),
//       floatingLabelBehavior: FloatingLabelBehavior.always,

//       floatingLabelStyle: const TextStyle(
//         color: AppColorsLight.primary,
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),

//       filled: true,
//       fillColor: AppColorsLight.grey100,
//       hintStyle: TextStyle(color: AppColorsLight.textSecondary),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: AppColorsLight.border),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: AppColorsLight.primary),
//       ),
//     ),

//     dividerColor: AppColorsLight.divider,

//     iconTheme: const IconThemeData(color: AppColorsLight.iconInactive),

//     textTheme: TextTheme(
//       bodyLarge: AppTextStyles.regular(16, color: AppColorsLight.textPrimary),
//       bodyMedium: AppTextStyles.regular(
//         14,
//         color: AppColorsLight.textSecondary,
//       ),
//       bodySmall: AppTextStyles.regular(12, color: AppColorsLight.textDisabled),
//     ),
//   );

//   // =========================
//   // 🌙 Dark Theme
//   // =========================
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: AppColorsDark.background,
//     primaryColor: AppColorsDark.primary,

//     colorScheme: const ColorScheme.dark(
//       primary: AppColorsDark.primary,
//       secondary: AppColorsDark.secondary,
//       surface: AppColorsDark.surface,
//       // surfaceContainerHighest: AppColorsDark.grey200,
//       onSurface: AppColorsDark.textPrimary,
//       onSurfaceVariant: AppColorsDark.textSecondary,
//     ),

//     cardTheme: CardThemeData(
//       color: AppColorsDark.card,
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     ),

//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColorsDark.background,
//       elevation: 0,
//       foregroundColor: AppColorsDark.textPrimary,
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: const TextStyle(
//         color: AppColorsDark.textSecondary,
//         fontSize: 14,
//       ),
//       floatingLabelStyle: const TextStyle(
//         color: AppColorsDark.primary,
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),
//       floatingLabelBehavior: FloatingLabelBehavior.always,

//       filled: true,
//       fillColor: AppColorsDark.grey200,
//       hintStyle: TextStyle(color: AppColorsDark.textSecondary),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: AppColorsDark.border),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: AppColorsDark.primary),
//       ),
//     ),

//     dividerColor: AppColorsDark.divider,

//     iconTheme: const IconThemeData(color: AppColorsDark.iconInactive),

//     textTheme: TextTheme(
//       bodyLarge: AppTextStyles.regular(16, color: AppColorsDark.textPrimary),
//       bodyMedium: AppTextStyles.regular(14, color: AppColorsDark.textSecondary),
//       bodySmall: AppTextStyles.regular(12, color: AppColorsDark.textDisabled),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  /// =========================
  /// 🌞 LIGHT THEME
  /// =========================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    primaryColor: AppColorsLight.primary,

    colorScheme: const ColorScheme.light(
      error: Colors.red,
      primary: AppColorsLight.primary,
      secondary: AppColorsLight.secondary,
      surface: AppColorsLight.surface,
      onSurface: AppColorsLight.textPrimary,
      onSurfaceVariant: AppColorsLight.textSecondary,
      tertiary: Color(0xffF59E0B),
    ),

    /// AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsLight.background,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColorsLight.textPrimary,
    ),

    /// Cards
    cardTheme: CardThemeData(
      color: AppColorsLight.card,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    /// Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    /// Floating button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorsLight.primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    /// Input fields
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColorsLight.textSecondary,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,

      floatingLabelStyle: const TextStyle(
        color: AppColorsLight.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      filled: true,
      fillColor: AppColorsLight.grey100,
      hintStyle: const TextStyle(color: AppColorsLight.textSecondary),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsLight.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsLight.primary, width: 1.5),
      ),
    ),

    /// Icons
    iconTheme: const IconThemeData(
      color: AppColorsLight.iconInactive,
      size: 22,
    ),

    /// Divider
    dividerColor: AppColorsLight.divider,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColorsLight.primary,
      unselectedItemColor: Colors.grey,
    ),

    /// Text
    textTheme: TextTheme(
      titleLarge: AppTextStyles.bold(20, color: AppColorsLight.textPrimary),
      titleMedium: AppTextStyles.semiBold(
        16,
        color: AppColorsLight.textPrimary,
      ),

      bodyLarge: AppTextStyles.regular(16, color: AppColorsLight.textPrimary),
      bodyMedium: AppTextStyles.regular(
        14,
        color: AppColorsLight.textSecondary,
      ),
      bodySmall: AppTextStyles.regular(12, color: AppColorsLight.textDisabled),
    ),
  );

  /// =========================
  /// 🌙 DARK THEME
  /// =========================
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    primaryColor: AppColorsDark.primary,

    colorScheme: const ColorScheme.dark(
      error: Colors.red,
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.secondary,
      surface: AppColorsDark.surface,
      onSurface: AppColorsDark.textPrimary,
      onSurfaceVariant: AppColorsDark.textSecondary,
      tertiary: Color(0xffF59E0B),
    ),

    /// AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.background,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColorsDark.textPrimary,
    ),

    /// Cards
    cardTheme: CardThemeData(
      color: AppColorsDark.card,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColorsLight.primary,
      unselectedItemColor: Colors.grey,
    ),

    /// Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    /// Floating button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorsDark.primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    /// Input fields
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColorsDark.textSecondary,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,

      floatingLabelStyle: const TextStyle(
        color: AppColorsDark.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      filled: true,
      fillColor: AppColorsDark.grey200,
      hintStyle: const TextStyle(color: AppColorsDark.textSecondary),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsDark.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsDark.primary, width: 1.5),
      ),
    ),

    /// Icons
    iconTheme: const IconThemeData(color: AppColorsDark.iconInactive, size: 22),

    dividerColor: AppColorsDark.divider,

    /// Text
    textTheme: TextTheme(
      titleLarge: AppTextStyles.bold(20, color: AppColorsDark.textPrimary),
      titleMedium: AppTextStyles.semiBold(16, color: AppColorsDark.textPrimary),

      bodyLarge: AppTextStyles.regular(16, color: AppColorsDark.textPrimary),
      bodyMedium: AppTextStyles.regular(14, color: AppColorsDark.textSecondary),
      bodySmall: AppTextStyles.regular(12, color: AppColorsDark.textDisabled),
    ),
  );
}
