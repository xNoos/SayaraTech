import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sayaratech/app/service/database.dart';
import '../../../service/alert.dart';
import '../../../service/check_connection.dart';

class AddCarController extends GetxController {
  RxBool isChooseVendor = false.obs;
  RxBool isChooseModel = false.obs;
  RxBool showBoardHint = false.obs;
  RxBool loading = false.obs;

  TextEditingController carVendorConroller = TextEditingController();
  TextEditingController carModelConroller = TextEditingController();
  TextEditingController carColorConroller = TextEditingController();
  TextEditingController carModelYearConroller = TextEditingController();
  TextEditingController carBoard1NoConroller = TextEditingController();
  TextEditingController carBoard2NoConroller = TextEditingController();
  TextEditingController carLicNoConroller = TextEditingController();
  TextEditingController carModelsEngineConroller = TextEditingController();
  TextEditingController carFuleTypeConroller = TextEditingController();

  RxString vendorId = "".obs;
  RxString modelId = "".obs;
  RxString colorId = "".obs;
  RxString fuelTypeId = "".obs;
  RxString modelsEngineId = "".obs;

  RxList vendors = RxList([]);
  RxList allVendors = RxList([]);
  RxList models = RxList([]);
  RxList allModels = RxList([]);
  RxList colors = RxList([]);
  RxList allColors = RxList([]);
  RxList fuelTypes = RxList([]);
  RxList allFuelTypes = RxList([]);
  RxList modelsEngine = RxList([]);
  RxList allModelsEngine = RxList([]);
  RxList modelsYears = RxList([]);
  RxList allModelsYears = RxList([]);

  getVendors() async {
    final response = await http.get(
        Uri.parse(Database.serverUrl + Database.getVendors),
        headers: Database.header);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      vendors.value = allVendors.value = result['Data'];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  getModels({required String vendorId}) async {
    final response = await http.get(
        Uri.parse(Database.serverUrl + Database.getModels),
        headers: Database.header);
    final result = await jsonDecode(response.body);

    if (result['status']) {
      models.value = allModels.value = result['Data']
          .where((element) => element['car_vendor_id'].toString() == vendorId)
          .toList();
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  getColors() async {
    final response = await http.get(
        Uri.parse(Database.serverUrl + Database.getColors),
        headers: Database.header);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      models.value = allColors.value = result['Data'];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  getFuelTypes() async {
    final response = await http.get(
        Uri.parse(Database.serverUrl + Database.getFuelTypes),
        headers: Database.header);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      fuelTypes.value = allFuelTypes.value = result['Data'];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  getModelsEngine({required String modelId}) async {
    final response = await http.get(
        Uri.parse(Database.serverUrl + Database.getModelsEngine + modelId),
        headers: Database.header);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      modelsEngine.value = allModelsEngine.value = result['Data'];
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  getModelYears() {
    modelsYears.clear();
    allModelsYears.clear();
    DateTime date = DateTime(DateTime.now().year + 1);
    while (date.isAfter(DateTime(1969))) {
      modelsYears.add(date.year);
      allModelsYears.add(date.year);
      date = DateTime(date.year - 1);
    }
  }

  addCar() async {
    bool success = await CheckConnection.checkConnection();
    if (!success) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "Check your internet connection then try again".tr));
      return;
    }
    if (vendorId.value == "") {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose car type".tr));
    } else if (modelId.value == "") {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose car model".tr));
    } else if (modelsEngineId.value == "") {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose models engine".tr));
    } else if (fuelTypeId.value == "") {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose fuel type".tr));
    } else if (carLicNoConroller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter car serial number".tr));
    } else if (carBoard1NoConroller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter board numbers".tr));
    } else if (carBoard2NoConroller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please enter board letters".tr));
    } else if (carColorConroller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose car color".tr));
    } else if (carModelYearConroller.text.trim().isEmpty) {
      Get.showSnackbar(
          Alert.AlertSnackBar(message: "Please choose car model year".tr));
    } else {
      Map body = {
        "Car_Vendor_id": vendorId.value,
        "Car_Model_id": modelId.value,
        "Car_Color_id": colorId.value,
        "Model_Year": carModelYearConroller.text,
        "Board_No": "${carBoard1NoConroller.text} ${carBoard2NoConroller.text}",
        "Car_Lic_No": carLicNoConroller.text,
        // "Last_KMs_Usages": 100,
        "Car_Models_Engine_id": modelsEngineId.value,
        "Car_Fule_Type_id": fuelTypeId.value
      };
      final response = await http.post(
          Uri.parse(Get.arguments == null
              ? Database.serverUrl + Database.addCar
              : '${Database.serverUrl}${Database.updateCar}?id=${Get.arguments['carId']}'),
          headers: Database.headerWithToken,
          body: jsonEncode(body));
      final result = await jsonDecode(response.body);

      if (result['status']) {
        Get.back(canPop: true, closeOverlays: true);
        Get.showSnackbar(Alert.SuccessSnackBar(
            message: Get.arguments == null
                ? "Car has been addes successfully".tr
                : "Car has been updated successfully"));
      } else {
        Get.showSnackbar(Alert.ErrorSnackBar(
            message:
                result['error'] != "" ? result['error'] : result['message']));
      }
    }
  }

  getCarData(String carId) async {
    bool success = await CheckConnection.checkConnection();
    if (!success) {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message: "Check your internet connection then try again".tr));
      return;
    }
    final response = await http.post(
        Uri.parse('${Database.serverUrl}${Database.getOneCar}/$carId'),
        headers: Database.headerWithToken);
    final result = await jsonDecode(response.body);
    if (result['status']) {
      Map data = result["Data"];
      vendorId.value = data['Car_Vendor_id'].toString();
      modelId.value = data['Car_Model_id'].toString();
      colorId.value = data['Car_Color_id'].toString();
      modelsEngineId.value = data['Cylinder_id'].toString();
      fuelTypeId.value = data['Car_Fule_Type_id'].toString();

      carVendorConroller.text = data[
              Get.locale.toString() == "ar" ? 'Vendor_name' : 'Vendor_egn_name']
          .toString();
      carModelConroller.text = data[
              Get.locale.toString() == "ar" ? 'Models_name' : 'Models_eng_name']
          .toString();
      carColorConroller.text =
          data[Get.locale.toString() == "ar" ? 'color_name' : 'color_eng_name']
              .toString();
      carFuleTypeConroller.text = data[Get.locale.toString() == "ar"
              ? 'Fule_Type_name'
              : 'Fule_Type_eng_name']
          .toString();
      carModelYearConroller.text = data['Model_Year'].toString();
      carLicNoConroller.text = data['Car_Lic_No'].toString();
      carBoard1NoConroller.text =
          data['Board_No'].toString().split(" ")[0].toString();
      carBoard2NoConroller.text =
          data['Board_No'].toString().split(" ")[1].toString();
      await getModels(vendorId: vendorId.value);
      await getModelsEngine(modelId: modelId.value);
      carModelsEngineConroller.text = modelsEngine
          .where((p0) => p0['id'].toString() == modelsEngineId.value)
          .toList()
          .first['name']
          .toString();
      loading.value = false;
    } else {
      Get.showSnackbar(Alert.ErrorSnackBar(
          message:
              result['error'] != "" ? result['error'] : result['message']));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    await getVendors();
    await getFuelTypes();
    await getColors();
    await getModelYears();
    loading.value = false;

    if (Get.arguments != null) {
      loading.value = true;
      isChooseModel.value = true;
      isChooseVendor.value = true;
      getCarData(Get.arguments['carId']);
    }
  }
}
