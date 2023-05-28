import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sayaratech/app/routes/app_pages.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/app_images.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            height: Get.height / 2,
            color: AppColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 100,
                  color: Colors.white,
                ),
                const Icon(FontAwesomeIcons.circleInfo,
                    size: 35, color: Colors.white)
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 20),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 50),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(55),
                              topRight: Radius.circular(55))),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Obx(() {
                            return controller.loading.value
                                ? SpinKitThreeBounce(
                                    color: AppColors.primaryColor, size: 20.0)
                                : Text(
                                    controller.user['name'].toString(),
                                    style: Get.textTheme.bodyLarge!.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.w900),
                                  );
                          }),
                          Text(
                            "Account Settings".tr,
                            style: TextStyle(color: AppColors.primaryColor),
                          ).marginOnly(top: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColors.greyColor.withOpacity(.1),
                                      blurRadius: 10,
                                      spreadRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2,
                                    color:
                                        AppColors.greyColor.withOpacity(.1))),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text(
                                      "Give this code to someone who is dear to you, and you will be rewarded with the wallet"
                                          .tr,
                                      textAlign: TextAlign.center,
                                    ),
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.copy,
                                                  color: AppColors.primaryColor,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "1Y010046",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )
                                              ],
                                            ),
                                          )),
                                    ).marginOnly(top: 20),
                                  ],
                                )),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.primaryColor,
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [Text("Personal Account".tr)],
                              ),
                              const SizedBox(height: 20),
                              option(
                                  title: "Reservations and billing",
                                  icon: CupertinoIcons.square_list_fill),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppPages.MY_CARS),
                                child: option(
                                    title: "My Cars".tr,
                                    icon: FontAwesomeIcons.car),
                              ),
                              option(
                                  title: "Addresses".tr,
                                  icon: FontAwesomeIcons.locationDot),
                              option(
                                  title: "Cashback".tr,
                                  icon: FontAwesomeIcons.moneyBill1Wave),
                            ],
                          ).paddingSymmetric(horizontal: 10),
                          Obx(() {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.locale.value = "ar";
                                      Get.updateLocale(const Locale("ar"));
                                      GetStorage().write('language', "ar");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: controller.locale.value == "ar"
                                              ? AppColors.primaryColor
                                              : Colors.white,
                                          border: Border.all(
                                            color:
                                                controller.locale.value == "en"
                                                    ? AppColors.primaryColor
                                                    : Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          'العربية',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: controller
                                                              .locale.value ==
                                                          "ar"
                                                      ? Colors.white
                                                      : AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.locale.value = "en";
                                      Get.updateLocale(const Locale("en"));
                                      GetStorage().write('language', "en");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: controller.locale.value == "en"
                                              ? AppColors.primaryColor
                                              : Colors.white,
                                          border: Border.all(
                                            color:
                                                controller.locale.value == "ar"
                                                    ? AppColors.primaryColor
                                                    : Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          'English',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: controller
                                                              .locale.value ==
                                                          "en"
                                                      ? Colors.white
                                                      : AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ).marginSymmetric(horizontal: 20, vertical: 10);
                          }),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red[900]),
                                onPressed: () {
                                  GetStorage().erase();
                                  Get.offAllNamed(AppPages.LOGIN);
                                },
                                child: Text(
                                  "LOGOUT".tr,
                                  style: Get.textTheme.bodyMedium!
                                      .copyWith(color: Colors.white),
                                )).marginSymmetric(horizontal: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4, color: AppColors.primaryColor),
                            shape: BoxShape.circle,
                            color: Colors.white),
                        child: Obx(() {
                          return Center(
                              child: controller.loading.value
                                  ? SpinKitFadingCircle(
                                      color: AppColors.primaryColor, size: 20.0)
                                  : Text(
                                      controller.user['name']
                                          .toString()
                                          .split("")
                                          .first
                                          .toString(),
                                      style: Get.textTheme.titleLarge!
                                          .copyWith(fontSize: 30.0),
                                    ));
                        }),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static option({required String title, required var icon}) => Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.blackColor.withOpacity(.7),
              ),
              const SizedBox(width: 10),
              Text(
                title.tr,
                style: Get.textTheme.bodySmall,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.greyColor.withOpacity(.5),
              ),
            ],
          ),
          Divider(
            color: AppColors.greyColor.withOpacity(.3),
          ),
        ],
      );
}
