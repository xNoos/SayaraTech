import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/app_images.dart';

import '../controllers/add_car_controller.dart';

class AddCarView extends GetView<AddCarController> {
  const AddCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AddCarController());
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              Get.arguments != null ? 'Update Car'.tr : 'Add Car'.tr,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          body: controller.loading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.logo, width: 150),
                    const SizedBox(height: 40),
                    SpinKitThreeBounce(
                      color: AppColors.primaryColor,
                    )
                  ],
                )
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanDown: (_) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Car Information".tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                              color: AppColors.blackColor, fontSize: 18.0),
                        ),
                        const SizedBox(height: 10),
                        menu(
                          hint: "Choose Car Type".tr,
                          textController: controller.carVendorConroller,
                          data: controller.vendors,
                          allData: controller.allVendors,
                          id: controller.vendorId,
                        ),
                        Visibility(
                            visible: controller.isChooseVendor.value,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                menu(
                                  hint: "Choose Car Model".tr,
                                  textController: controller.carModelConroller,
                                  data: controller.models,
                                  allData: controller.allModels,
                                  id: controller.modelId,
                                ),
                              ],
                            )),
                        Visibility(
                            visible: controller.isChooseModel.value,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                menu(
                                  hint: "Choose Car Model Engines".tr,
                                  textController:
                                      controller.carModelsEngineConroller,
                                  data: controller.modelsEngine,
                                  allData: controller.allModelsEngine,
                                  id: controller.modelsEngineId,
                                )
                              ],
                            )),
                        const SizedBox(height: 20),
                        menu(
                          hint: "Choose Car Fuel Type".tr,
                          textController: controller.carFuleTypeConroller,
                          data: controller.fuelTypes,
                          allData: controller.allFuelTypes,
                          id: controller.fuelTypeId,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Car Registration Information".tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                              color: AppColors.blackColor, fontSize: 18.0),
                        ),
                        const SizedBox(height: 10),
                        simpleField(
                            hint: "Serial Number".tr,
                            textController: controller.carLicNoConroller),
                        const SizedBox(height: 20),
                        boardField(
                            hint1: "Board Numbers".tr,
                            hint2: "Board Lettering".tr,
                            textController1: controller.carBoard1NoConroller,
                            textController2: controller.carBoard2NoConroller),
                        Visibility(
                          visible: controller.showBoardHint.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.circleInfo,
                                      color: Colors.red[900]),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "${"The letters of the board must be one of these letters:".tr} A-B-D-E-G-H-J-K-L-N-R-S-T-U-V-X-Z\nا-ب-د-ر-س-ص-ط-ع-ق-ك-ل-م-ن-ه-و-ى",
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Additional Information".tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                              color: AppColors.blackColor, fontSize: 18.0),
                        ),
                        const SizedBox(height: 10),
                        menu(
                          hint: "Choose Car Color".tr,
                          textController: controller.carColorConroller,
                          data: controller.colors,
                          allData: controller.allColors,
                          id: controller.colorId,
                        ),
                        const SizedBox(height: 20),
                        simpleMenu(
                          hint: "Choose Car Model Year".tr,
                          textController: controller.carModelYearConroller,
                          data: controller.modelsYears,
                          allData: controller.allModelsYears,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () => controller.addCar(),
                                child: Text(
                                  Get.arguments != null
                                      ? "Update".tr
                                      : "Confirm".tr,
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white, fontSize: 16.0),
                                ))).marginOnly(top: 20, bottom: 20)
                      ],
                    ),
                  ),
                ));
    });
  }

  TextField simpleField(
          {required String hint,
          required TextEditingController textController}) =>
      TextField(
          controller: textController,
          style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
          cursorColor: AppColors.secondColor,
          decoration: InputDecoration(
              hintText: hint.tr, hintStyle: Get.textTheme.bodySmall),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number);

  Row boardField(
          {required String hint1,
          required String hint2,
          required TextEditingController textController1,
          required TextEditingController textController2}) =>
      Row(
        children: [
          Expanded(
            child: TextField(
                controller: textController1,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                cursorColor: AppColors.secondColor,
                decoration: InputDecoration(
                    counterText: '',
                    hintText: hint1.tr,
                    hintStyle: Get.textTheme.bodySmall,
                    border: Get.locale.toString() == "ar"
                        ? const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            borderSide: BorderSide.none)
                        : const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            borderSide: BorderSide.none)),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number),
          ),
          Container(
            height: 48,
            color: AppColors.greyColor.withOpacity(.1),
            child: Image.asset(
              AppImages.saudiLogo,
              width: 25,
            ),
          ),
          Expanded(
            child: TextField(
              controller: textController2,
              maxLength: 3,
              textAlign: TextAlign.center,
              style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
              cursorColor: AppColors.secondColor,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  counterText: '',
                  hintText: hint2.tr,
                  hintStyle: Get.textTheme.bodySmall,
                  border: Get.locale.toString() == "ar"
                      ? const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                          borderSide: BorderSide.none)
                      : const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          borderSide: BorderSide.none)),
              onChanged: (v) {
                List letter = [
                  'C',
                  'F',
                  'I',
                  'M',
                  'O',
                  'P',
                  'Q',
                  'W',
                  'ت',
                  'ذ',
                  'ز',
                  'خ',
                  'ض',
                  'ظ',
                  'غ',
                  'ف',
                  'ي'
                ];
                List word = v.split("");
                log(v.length.toString());
                for (var element in word) {
                  if (letter.contains(element)) {
                    controller.showBoardHint.value = true;
                    textController2.text =
                        textController2.text.replaceFirst(element, "");
                    if (textController2.text.isNotEmpty) {
                      textController2.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController2.text.length));
                    }
                  } else {
                    controller.showBoardHint.value = false;
                  }
                }
              },
            ),
          ),
        ],
      );

  GestureDetector menu(
          {required String hint,
          required TextEditingController textController,
          required RxList data,
          required RxList allData,
          required RxString id}) =>
      GestureDetector(
        onTap: () => bottomSheetMenu(
            data: data,
            allData: allData,
            textController: textController,
            id: id),
        child: TextField(
            controller: textController,
            enabled: false,
            style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
            cursorColor: AppColors.secondColor,
            decoration: InputDecoration(
                hintText: hint.tr,
                hintStyle: Get.textTheme.bodySmall,
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            keyboardType: TextInputType.emailAddress),
      );

  bottomSheetMenu(
      {required RxList data,
      required RxList allData,
      required TextEditingController textController,
      required RxString id}) {
    TextEditingController search = TextEditingController();

    filtterList({required String value}) {
      data.value = allData
          .where((name) =>
              name[textController == controller.carModelsEngineConroller
                      ? "name"
                      : Get.locale.toString() == "ar"
                          ? "name"
                          : "eng_name"]
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              name[textController == controller.carModelsEngineConroller
                      ? "name"
                      : Get.locale.toString() == "ar"
                          ? "name"
                          : "eng_name"]
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    }

    filtterList(value: "");

    return Get.bottomSheet(backgroundColor: Colors.white, Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 70,
              decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(20)),
            ).marginOnly(bottom: 15, top: 10),
            TextField(
                controller: search,
                style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                cursorColor: AppColors.secondColor,
                decoration: InputDecoration(
                    hintText: "Search".tr,
                    hintStyle: Get.textTheme.bodySmall,
                    suffixIcon: search.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              search.clear();
                              filtterList(value: "");
                            },
                            child: const Icon(Icons.clear))
                        : const SizedBox()),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => filtterList(value: v)),
            Expanded(
                child: data.isEmpty
                    ?  Center(child: Text("No Data Found".tr))
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  textController.text = textController ==
                                          controller.carModelsEngineConroller
                                      ? data[index]["name"].toString()
                                      : data[index][
                                          Get.locale.toString() == "ar"
                                              ? "name"
                                              : "eng_name"];
                                  id.value = data[index]["id"].toString();
                                  if (textController ==
                                      controller.carVendorConroller) {
                                    controller.getModels(
                                        vendorId: data[index]["id"].toString());
                                    controller.isChooseVendor.value = true;
                                  }
                                  if (textController ==
                                      controller.carModelConroller) {
                                    controller.getModelsEngine(
                                        modelId: data[index]["id"].toString());
                                    controller.isChooseModel.value = true;
                                  }
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textController ==
                                                  controller
                                                      .carModelsEngineConroller
                                              ? data[index]["name"].toString()
                                              : data[index][
                                                      Get.locale.toString() ==
                                                              "ar"
                                                          ? "name"
                                                          : "eng_name"]
                                                  .toString(),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: AppColors.greyColor,
                              )
                            ],
                          ).marginSymmetric(horizontal: 15);
                        }))
          ],
        ),
      );
    }));
  }

  GestureDetector simpleMenu(
          {required String hint,
          required TextEditingController textController,
          required RxList data,
          required RxList allData}) =>
      GestureDetector(
        onTap: () => bottomSheetSimpleMenu(
            data: data, allData: allData, textController: textController),
        child: TextField(
            controller: textController,
            enabled: false,
            style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
            cursorColor: AppColors.secondColor,
            decoration: InputDecoration(
                hintText: hint.tr,
                hintStyle: Get.textTheme.bodySmall,
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            keyboardType: TextInputType.emailAddress),
      );

  bottomSheetSimpleMenu(
      {required RxList data,
      required RxList allData,
      required TextEditingController textController}) {
    TextEditingController search = TextEditingController();

    filtterList({required String value}) {
      data.value = allData
          .where((name) =>
              name.toString().contains(value) ||
              name.toString().contains(value))
          .toList();
    }

    filtterList(value: "");

    return Get.bottomSheet(backgroundColor: Colors.white, Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 70,
              decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(20)),
            ).marginOnly(bottom: 15, top: 10),
            TextField(
                controller: search,
                style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                cursorColor: AppColors.secondColor,
                decoration: InputDecoration(
                    hintText: "Search".tr,
                    hintStyle: Get.textTheme.bodySmall,
                    suffixIcon: search.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              search.clear();
                              filtterList(value: "");
                            },
                            child: const Icon(Icons.clear))
                        : const SizedBox()),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => filtterList(value: v)),
            Expanded(
                child: data.isEmpty
                    ? Center(child: Text("No Data Found".tr))
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  textController.text = data[index].toString();

                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data[index].toString(),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: AppColors.greyColor,
                              )
                            ],
                          ).marginSymmetric(horizontal: 15);
                        }))
          ],
        ),
      );
    }));
  }
}
