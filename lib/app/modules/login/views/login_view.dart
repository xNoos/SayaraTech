import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sayaratech/app/routes/app_pages.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/app_images.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Row(
                    children: [
                      GestureDetector(
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
                                color: controller.locale.value == "en"
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'Arabic',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.locale.value == "ar"
                                    ? Colors.white
                                    : AppColors.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
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
                                color: controller.locale.value == "ar"
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'English',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.locale.value == "en"
                                    ? Colors.white
                                    : AppColors.primaryColor),
                          ),
                        ),
                      )
                    ],
                  );
                }),
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                  ),
                ).marginOnly(top: 80),
                Text(
                  "LOGIN".tr,
                  style: Get.textTheme.displayMedium!.copyWith(fontSize: 40.0),
                ).marginOnly(top: 80),
                Text(
                  "Login and enjoy all the services!".tr,
                ),
                Text(
                  "Phone Number".tr,
                  style: Get.textTheme.displaySmall,
                ).marginOnly(top: 50, bottom: 10),
                TextField(
                    maxLength: 9,
                    controller: controller.mobileContoller,
                    style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                    cursorColor: AppColors.secondColor,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: "Enter your phone number".tr,
                        hintStyle: Get.textTheme.bodySmall,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(FontAwesomeIcons.mobileButton),
                            Text("+966",
                                style: Get.textTheme.headlineSmall!.copyWith(
                                  fontSize: 12,
                                  color: AppColors.secondColor.withOpacity(.5),
                                )),
                          ],
                        ).paddingSymmetric(horizontal: 10)),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
                    ],
                    keyboardType: TextInputType.number),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.login(),
                      child: Text("LOGIN".tr,
                          style: Get.textTheme.displayMedium!
                              .copyWith(color: Colors.white))),
                ).marginOnly(top: 30),
                Row(
                  children: [
                    const Text('Dont have an account?'),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppPages.SIGNUP),
                      child: Text('SIGNUP NOW!',
                          style: TextStyle(color: AppColors.primaryColor)),
                    )
                  ],
                ).marginOnly(top: 50)
              ],
            )));
  }
}
