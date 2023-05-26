import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/service/settings_service.dart';
import 'app/service/translation_service.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut(() => TranslationService());
  Get.lazyPut(() => SettingsService());
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.LOGIN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: Get.find<SettingsService>().getLightTheme(),
      // locale: Get.find<TranslationService>().getLocale(),
      locale: const Locale("en"),
    ),
  );
}
