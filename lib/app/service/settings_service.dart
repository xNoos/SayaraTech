import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/translation_service.dart';

class SettingsService {
  ThemeData getLightTheme() {
    log(Get.find<TranslationService>().getLocale().languageCode);
    return ThemeData(
        primaryColor: AppColors.greyColor,
        useMaterial3: true,
        brightness: Brightness.light,
        dividerColor: AppColors.secondColor,
        focusColor: AppColors.secondColor,
        hintColor: AppColors.secondColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
            unselectedIconTheme:
                IconThemeData(color: AppColors.greyColor.withOpacity(.5)),
            unselectedItemColor: AppColors.greyColor.withOpacity(.5),
            selectedItemColor: AppColors.primaryColor,
            elevation: 0,
            selectedLabelStyle: const TextStyle(height: 2),
            showUnselectedLabels: true),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                textStyle:
                    Get.textTheme.bodyMedium!.copyWith(color: Colors.white))),
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: AppColors.greyColor.withOpacity(.1),
            suffixIconColor: AppColors.secondColor.withOpacity(.3),
            prefixIconColor: AppColors.secondColor.withOpacity(.3),
            hintStyle: Get.textTheme.bodySmall,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        iconTheme: IconThemeData(color: AppColors.secondColor),
        textTheme: GoogleFonts.getTextTheme(
          // Get.find<TranslationService>().getLocale().languageCode == "en"
          //     ? 'Poppins'
          //     : 'Cairo',
          'Cairo',
          TextTheme(
            titleLarge: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
                height: 1.3),
            headlineSmall: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: AppColors.secondColor,
                height: 1.3),
            headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: AppColors.secondColor,
                height: 1.3),
            displaySmall: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: AppColors.secondColor,
                height: 1.3),
            displayMedium: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
                height: 1.4),
            displayLarge: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: AppColors.secondColor,
                height: 1.4),
            titleSmall: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: AppColors.secondColor,
                height: 1.2),
            titleMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
                height: 1.2),
            bodyMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: AppColors.secondColor,
                height: 1.2),
            bodyLarge: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: AppColors.secondColor,
                height: 1.2),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: AppColors.blackColor,
                height: 1.2),
          ),
        ));
  }
}
