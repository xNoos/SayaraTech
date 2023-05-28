import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sayaratech/app/service/database.dart';

import '../../../service/alert.dart';
import '../../../service/check_connection.dart';
import '../../../service/translation_service.dart';

class ProfileController extends GetxController {
  RxMap user = {}.obs;
  RxBool loading = true.obs;
  RxString locale =
      RxString(Get.find<TranslationService>().getLocale().languageCode);
  getUserData() async {
    bool success = await CheckConnection.checkConnection();
    if (!success) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "Check your internet connection then try again".tr));
      return;
    }
    final response = await http.post(
        Uri.parse(Database.serverUrl + Database.profile),
        headers: Database.headerWithToken);
    final result = await jsonDecode(response.body);
    log(response.body.toString());
    log(response.statusCode.toString());
    if (result['status']) {
      user.value = result["Data"];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
    loading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
}
