import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../service/app_colors.dart';
import '../../../service/app_images.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                  ),
                ).marginOnly(top: 80),
                Text(
                  "SIGNUP".tr,
                  style: Get.textTheme.displayMedium!.copyWith(fontSize: 40.0),
                ).marginOnly(top: 80),
                Text(
                  "Signup and enjoy all the services!".tr,
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
                      FilteringTextInputFormatter.digitsOnly
                    ], //
                    keyboardType: TextInputType.number),
                TextField(
                        controller: controller.nameContoller,
                        style:
                            Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                        cursorColor: AppColors.secondColor,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          counterText: '',
                          prefixIcon:
                              const Icon(FontAwesomeIcons.solidCircleUser),
                          hintText: "Enter your name".tr,
                          hintStyle: Get.textTheme.bodySmall,
                        ),
                        keyboardType: TextInputType.emailAddress)
                    .marginOnly(top: 15),
                TextField(
                        controller: controller.emailContoller,
                        style:
                            Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                        cursorColor: AppColors.secondColor,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          counterText: '',
                          prefixIcon:
                              const Icon(FontAwesomeIcons.solidEnvelope),
                          hintText: "Enter your email address".tr,
                          hintStyle: Get.textTheme.bodySmall,
                        ),
                        keyboardType: TextInputType.emailAddress)
                    .marginOnly(top: 15),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.login(),
                      child: Text("SIGNUP".tr,
                          style: Get.textTheme.displayMedium!
                              .copyWith(color: Colors.white))),
                ).marginOnly(top: 30),
              ],
            )));
  }
}
