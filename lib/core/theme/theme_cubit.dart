import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storage/cache_helper.dart';
import '../storage/cache_keys.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  /// 🔄 Toggle Theme
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    emit(newMode);

    await _saveTheme(newMode);
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    await CacheHelper.insertToCache(
      key: CacheKeys.themeKey,
      value: (mode == ThemeMode.dark).toString(),
    );
  }

  Future<void> _loadTheme() async {
    final cachedValue = CacheHelper.getCacheData(key: CacheKeys.themeKey);

    if (cachedValue == null) {
      emit(ThemeMode.light);
      return;
    }

    final isDark = cachedValue == "true";

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
