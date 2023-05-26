import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sayaratech/app/routes/app_pages.dart';
import 'package:sayaratech/app/service/alert.dart';
import 'package:http/http.dart' as http;
import 'package:sayaratech/app/service/database.dart';
import '../../../service/translation_service.dart';

class LoginController extends GetxController {
  TextEditingController mobileContoller = TextEditingController();

  RxString locale =
      RxString(Get.find<TranslationService>().getLocale().languageCode);
  login() async {
    bool isValid =
        await PhoneNumberUtil().validate('+966${mobileContoller.text}');
    if (mobileContoller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter your phone number".tr));
    } else if (!isValid) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "The entered mobile number is incorrect".tr));
    } else {
      final response = await http.post(
          Uri.parse(
              '${Database.serverUrl}${Database.login}?mobileno=966${mobileContoller.text}'),
          headers: Database.header);
      final result = await jsonDecode(response.body);
      if (result['status']) {
        Get.toNamed(AppPages.OTP, arguments: {
          "mobile": mobileContoller.text,
          "id_step2": result['Data']["id_step2"],
          "smscode": result['Data']["smscode"],
          "otp": Database.loginOtp
        });
      } else {
        Get.showSnackbar(Alert.ErrorSnackBar(
            message:
                result['error'] != "" ? result['error'] : result['message']));
      }
    }
  }
}
