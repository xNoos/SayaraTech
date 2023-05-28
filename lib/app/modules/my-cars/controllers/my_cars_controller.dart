import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sayaratech/app/service/database.dart';
import 'package:sayaratech/app/service/check_connection.dart';
import '../../../service/alert.dart';

class MyCarsController extends GetxController {
  RxList myCars = RxList([]);
  RefreshController refreshController = RefreshController(initialRefresh: true);

  getMyCars() async {
    bool success = await CheckConnection.checkConnection();
    if (!success) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "Check your internet connection then try again".tr));
      refreshController.refreshCompleted();
      return;
    }
    final response = await http.post(
        Uri.parse(Database.serverUrl + Database.getAllCars),
        headers: Database.headerWithToken);

    final result = await jsonDecode(response.body);
    if (result['status']) {
      myCars.value = result['Data'];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
    refreshController.refreshCompleted();
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  @override
  void onInit() {
    super.onInit();
    getMyCars();
  }
}
