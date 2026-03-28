// import 'package:flutter/material.dart';

// class AppColorsLight {
//   // Base
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);

//   // Greys
//   static const Color grey50 = Color(0xFFFAFAFA);
//   static const Color grey100 = Color(0xFFF5F5F5);
//   static const Color grey200 = Color(0xFFEEEEEE);
//   static const Color grey300 = Color(0xFFE0E0E0);
//   static const Color grey400 = Color(0xFFBDBDBD);
//   static const Color grey500 = Color(0xFF9E9E9E);
//   static const Color grey600 = Color(0xFF757575);
//   static const Color grey700 = Color(0xFF616161);
//   static const Color grey800 = Color(0xFF424242);
//   static const Color grey900 = Color(0xFF212121);

//   // Theme colors
//   // static const Color primary = black;
//   // static const Color secondary = grey800;
//   // static const Color accent = grey600;
//   static const Color primary = Color(0xff2563EB); // أزرق smart
//   static const Color secondary = Color(0xff00C2A8); // تركواز
//   static const Color accent = Color(0xff22C55E); // أخضر tracking

//   // Backgrounds
//   // static const Color background = white;
//   // static const Color surface = grey50;
//   // static const Color card = white;
//   static const Color background = Color(0xffF5F7FA);
//   static const Color surface = Color(0xffEEF2F6);
//   static const Color card = white;

//   // Text
//   static const Color textPrimary = black;
//   static const Color textSecondary = grey700;
//   static const Color textDisabled = grey400;

//   // Borders & Dividers
//   static const Color border = grey300;
//   static const Color divider = grey200;

//   // Icons
//   // static const Color iconActive = black;
//   static const Color iconActive = primary;

//   static const Color iconInactive = grey500;
// }

// class AppColorsDark {
//   // Base
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);

//   // Greys
//   static const Color grey50 = Color(0xFF1E1E1E);
//   static const Color grey100 = Color(0xFF2A2A2A);
//   static const Color grey200 = Color(0xFF333333);
//   static const Color grey300 = Color(0xFF3D3D3D);
//   static const Color grey400 = Color(0xFF555555);
//   static const Color grey500 = Color(0xFF777777);
//   static const Color grey600 = Color(0xFF999999);
//   static const Color grey700 = Color(0xFFBDBDBD);
//   static const Color grey800 = Color(0xFFE0E0E0);
//   static const Color grey900 = Color(0xFFF5F5F5);

//   // Theme colors
//   // static const Color primary = white;
//   // static const Color secondary = grey800;
//   // static const Color accent = grey600;
//   static const Color primary = Color(0xff3B82F6);
//   static const Color secondary = Color(0xff00C2A8);
//   static const Color accent = Color(0xff22C55E);

//   // Backgrounds
//   // static const Color background = Color(0xFF121212);
//   // static const Color surface = grey100;
//   // static const Color card = grey200;
//   static const Color background = Color(0xff0B0F14);
//   static const Color surface = Color(0xff111827);
//   static const Color card = Color(0xff161B22);

//   // Text
//   static const Color textPrimary = white;
//   static const Color textSecondary = grey700;
//   static const Color textDisabled = grey500;

//   // Borders & Dividers
//   static const Color border = grey300;
//   static const Color divider = grey200;

//   // Icons
//   // static const Color iconActive = white;
//   static const Color iconActive = primary;

//   static const Color iconInactive = grey500;
// }
import 'package:flutter/material.dart';

/// ===============================
/// 🌞 LIGHT COLORS
/// ===============================
class AppColorsLight {
  // Base
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Greys
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  /// 🎨 Smart Microbus Palette
  static const Color primary = Color(0xff2563EB); // main blue
  static const Color secondary = Color(0xff00C2A8); // teal transport
  static const Color accent = Color(0xff22C55E);
  // static const primary = Color(0xff1E3A8A); // Navy هادي
  // static const secondary = Color(0xff0EA5E9);
  // static const accent = Color(0xff22C55E); // tracking green
  static const Color warning = Color(0xffF59E0B);
  static const Color danger = Colors.red;

  // Backgrounds
  static const Color background = Color(0xffF5F7FA);
  static const Color surface = Color(0xffEEF2F6);
  static const Color card = white;

  // Text
  static const Color textPrimary = black;
  static const Color textSecondary = grey700;
  static const Color textDisabled = grey400;

  // Borders & Dividers
  static const Color border = grey300;
  static const Color divider = grey200;

  // Icons
  static const Color iconActive = primary;
  static const Color iconInactive = grey500;
}

/// ===============================
/// 🌙 DARK COLORS
/// ===============================
class AppColorsDark {
  // Base
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Greys
  static const Color grey50 = Color(0xFF1E1E1E);
  static const Color grey100 = Color(0xFF2A2A2A);
  static const Color grey200 = Color(0xFF333333);
  static const Color grey300 = Color(0xFF3D3D3D);
  static const Color grey400 = Color(0xFF555555);
  static const Color grey500 = Color(0xFF777777);
  static const Color grey600 = Color(0xFF999999);
  static const Color grey700 = Color(0xFFBDBDBD);
  static const Color grey800 = Color(0xFFE0E0E0);
  static const Color grey900 = Color(0xFFF5F5F5);

  /// 🎨 Smart Microbus Palette Dark
  static const Color primary = Color(0xff3B82F6);
  static const Color secondary = Color(0xff00C2A8);
  static const Color accent = Color(0xff22C55E);
  // static const primary = Color(0xff1E3A8A); // Navy هادي
  // static const secondary = Color(0xff0EA5E9);
  // static const accent = Color(0xff22C55E);
  static const Color warning = Color(0xffF59E0B);
  static const Color danger = Colors.red;

  // Backgrounds
  static const Color background = Color.fromARGB(255, 22, 31, 43);
  static const Color surface = Color(0xff111827);
  static const Color card = Color(0xff161B22);

  // Text
  static const Color textPrimary = white;
  static const Color textSecondary = grey700;
  static const Color textDisabled = grey500;

  // Borders & Dividers
  static const Color border = grey300;
  static const Color divider = grey200;

  // Icons
  static const Color iconActive = primary;
  static const Color iconInactive = grey500;
}
