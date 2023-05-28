import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sayaratech/app/modules/my-cars/controllers/my_cars_controller.dart';
import 'package:sayaratech/app/modules/profile/controllers/profile_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/service/settings_service.dart';
import 'app/service/translation_service.dart';
import 'generated/locales.g.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut(() => TranslationService());
  Get.lazyPut(() => SettingsService());
  Get.lazyPut(() => MyCarsController());
  Get.lazyPut(() => ProfileController());
  final token = GetStorage().read("token");
  runApp(
    GetMaterialApp(
        initialRoute: token == null ? AppPages.LOGIN : AppPages.MAIN_SCREEN,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        translationsKeys: AppTranslation.translations,
        theme: Get.find<SettingsService>().getLightTheme(),
        locale: Get.find<TranslationService>().getLocale()),
  );
}
