import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../service/alert.dart';
import '../../../service/database.dart';

class OtpController extends GetxController {
  Map data = Get.arguments;
  TextEditingController codeContoller = TextEditingController();
  RxInt timer = 0.obs;

  sendOtp() async {
    final response = await http.post(
        Uri.parse(
            '${Database.serverUrl}${data['otp']}?mobileno=966${data['mobile']}&step1id=${data['id_step2']}&smscode=${codeContoller.text}'),
        headers: Database.header);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      Get.offAllNamed(AppPages.MAIN_SCREEN);
      GetStorage().write("token", result['Data']);
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  startTimer() {
    timer.value = 60;
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value -= 1;
      } else {
        t.cancel();
      }
    });
  }

  resendCode() async {
    startTimer();
    if (data['otp'] == Database.loginOtp) {
      final response = await http.post(
          Uri.parse(
              '${Database.serverUrl}${Database.login}?mobileno=966${data['mobile']}'),
          headers: Database.header);
      final result = await jsonDecode(response.body);
      if (result['status']) {
        data['id_step2'] = result['Data']["id_step2"];
        Get.showSnackbar(Alert.SuccessSnackBar(
            message: "Code hase been sent successfully".tr));
      } else {
        Get.showSnackbar(Alert.ErrorSnackBar(
            message:
                result['error'] != "" ? result['error'] : result['message']));
      }
    } else {
      final response = await http.post(
          Uri.parse('${Database.serverUrl}${Database.signup}'),
          headers: Database.header,
          body: jsonEncode(data['body']));
      final result = await jsonDecode(response.body);
      log(result.toString());
      if (result['status']) {
        data['id_step2'] = result['Data']["id_step2"];
        Get.showSnackbar(Alert.SuccessSnackBar(
            message: "Code hase been sent successfully".tr));
      } else {
        Get.showSnackbar(Alert.ErrorSnackBar(
            message:
                result['error'] != "" ? result['error'] : result['message']));
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
