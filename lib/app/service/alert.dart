// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/app/service/app_colors.dart';

class Alert {
  static GetSnackBar SuccessSnackBar(
      {String title = 'Success',
      required String message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.displayMedium!.copyWith(color: Colors.white)),
      messageText: Text(message,
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.primaryColor,
      icon:
          const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'Error',
      required String message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.displayMedium!.copyWith(color: Colors.white)),
      messageText: Text(message,
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar AlertSnackBar(
      {String title = 'Alert', required String message}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.displayMedium!.copyWith(color: Colors.white)),
      messageText: Text(message,
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.secondColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: const Icon(Icons.warning_amber_rounded,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }
}
