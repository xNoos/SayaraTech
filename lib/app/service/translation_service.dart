import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TranslationService {
  Locale getLocale() {
    String? locale = GetStorage().read<String>('language');
    if (locale == null || locale.isEmpty) {
      locale = "en";
    }
    return Locale(locale);
  }
}
