import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';
import 'locale_storage.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LocaleStorage storage;

  /// Default = English
  LocaleCubit(this.storage) : super(const LocaleState(locale: Locale('en')));

  // =========================
  // Load Saved Locale
  // =========================
  Future<void> loadSavedLocale() async {
    final savedCode = storage.getSavedLocale();

    if (savedCode != null) {
      emit(LocaleState(locale: Locale(savedCode)));
    }
  }

  // =========================
  // Change Locale
  // =========================
  Future<void> changeLocale(String code) async {
    await storage.saveLocale(code);

    emit(LocaleState(locale: Locale(code)));
  }

  // =========================
  // Shortcuts
  // =========================
  Future<void> toArabic() async {
    await changeLocale('ar');
  }

  Future<void> toEnglish() async {
    await changeLocale('en');
  }

  // =========================
  // Reset Locale
  // =========================
  Future<void> resetLocale() async {
    await storage.clearLocale();

    emit(const LocaleState(locale: Locale('en')));
  }
}
