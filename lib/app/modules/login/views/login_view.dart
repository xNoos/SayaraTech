import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sayaratech/app/routes/app_pages.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/app_images.dart';
import 'package:sayaratech/app/service/settings_service.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
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
                            Get.changeTheme(
                                Get.find<SettingsService>().getLightTheme());
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
                              'العربية',
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
                            Get.changeTheme(
                                Get.find<SettingsService>().getLightTheme());
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
                    style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 40.0),
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
                      autofocus: true,
                      controller: controller.mobileContoller,
                      style:
                          Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                      cursorColor: AppColors.secondColor,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: "Enter your phone number".tr,
                          hintStyle: Get.textTheme.bodySmall,
                          prefixIcon: Icon(FontAwesomeIcons.mobileButton,
                              color: AppColors.primaryColor),
                          prefix: Get.locale.toString() == "en"
                              ? Text("+966 ",
                                  textDirection: TextDirection.ltr,
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: 12,
                                    color:
                                        AppColors.secondColor.withOpacity(.5),
                                  ))
                              : null,
                          suffix: Get.locale.toString() == "ar"
                              ? Text("+966 ",
                                  textDirection: TextDirection.ltr,
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: 12,
                                    color:
                                        AppColors.secondColor.withOpacity(.5),
                                  ))
                              : null),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return TextButton(
                          onPressed: () => controller.loading.value
                              ? null
                              : controller.login(),
                          child: controller.loading.value
                              ? const SpinKitThreeBounce(
                                  color: Colors.white, size: 30)
                              : Text("LOGIN".tr,
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(color: Colors.white)));
                    }),
                  ).marginOnly(top: 30),
                  Row(
                    children: [
                      Text('Dont have an account?'.tr),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppPages.SIGNUP),
                        child: Text('SIGNUP NOW!'.tr,
                            style: TextStyle(color: AppColors.primaryColor)),
                      )
                    ],
                  ).marginOnly(top: 50, bottom: 30)
                ],
              )),
        ));
  }
}
