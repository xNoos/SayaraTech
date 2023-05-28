import 'dart:convert';
import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';
import '../../../service/alert.dart';
import '../../../service/database.dart';

class SignupController extends GetxController {
  TextEditingController mobileContoller = TextEditingController();
  TextEditingController nameContoller = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  RxBool loading = false.obs;
  signup() async {
    bool isValid =
        await PhoneNumberUtil().validate('+966${mobileContoller.text}');
    if (mobileContoller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter your phone number".tr));
    } else if (!isValid) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "The entered mobile number is incorrect".tr));
    } else if (nameContoller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter your name".tr));
    } else if (nameContoller.text.trim().length < 3) {
      Get.showSnackbar(
          Alert.ErrorSnackBar(message: "Your name is too short".tr));
    } else if (emailContoller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter your email".tr));
    } else if (!EmailValidator.validate(emailContoller.text)) {
      Get.showSnackbar(
          Alert.ErrorSnackBar(message: "Your email is not correct".tr));
    } else {
      loading.value = true;
      Map body = {
        "name": nameContoller.text,
        "email": emailContoller.text,
        "mobile": mobileContoller.text
      };
      final response = await http.post(
          Uri.parse('${Database.serverUrl}${Database.signup}'),
          headers: Database.header,
          body: jsonEncode(body));
      final result = await jsonDecode(response.body);
      log(result.toString());
      if (result['status']) {
        Get.toNamed(AppPages.OTP, arguments: {
          "mobile": mobileContoller.text,
          "id_step2": result['Data']["id_step2"],
          "smscode": result['Data']["smscode"],
          "otp": Database.signupOtp,
          "body": body
        });
      } else {
        Get.showSnackbar(Alert.ErrorSnackBar(
            message:
                result['error'] != "" ? result['error'] : result['message']));
      }
      loading.value = false;
    }
  }
}
