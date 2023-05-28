import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sayaratech/app/service/database.dart';

import 'alert.dart';

class CheckConnection {
  static checkConnection() async {
    bool success = false;
    await http
        .post(Uri.parse("https://www.google.com"),
            headers: Database.headerRefreshToken)
        .then((response) async {
      success = true;
    }).catchError((e) {
      if (e.toString() == "Failed host lookup: 'www.google.com'") {
        success = false;
      }
    });
    if (!success) {
      return success;
    }

    DateTime tokenExpire = GetStorage().read("expires") != null
        ? DateTime.parse(GetStorage().read("expires"))
        : DateTime.now();
    if (tokenExpire.isBefore(DateTime.now())) {
      await http
          .post(Uri.parse(Database.serverUrl + Database.refreshToken),
              headers: Database.headerRefreshToken)
          .then((response) async {
        success = true;

        final result = await jsonDecode(response.body);
        if (result['status']) {
          GetStorage().write("token", result["Data"]["token"]);
          GetStorage().write("expires", result["Data"]["expires"]);
        } else {
          Get.showSnackbar(Alert.ErrorSnackBar(
              message:
                  result['error'] != "" ? result['error'] : result['message']));
        }
      }).catchError((e) {
        if (e.toString() == "Failed host lookup: 'satc.live'") {
          success = false;
        }
      });
    }

    return success;
  }
}
