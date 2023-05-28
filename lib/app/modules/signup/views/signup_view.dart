import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                  Center(
                    child: Image.asset(
                      AppImages.logo,
                      width: 200,
                    ),
                  ).marginOnly(top: 80),
                  Text(
                    "SIGNUP".tr,
                    style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 40.0),
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
                  TextField(
                          controller: controller.nameContoller,
                          style: Get.textTheme.displayMedium!
                              .copyWith(fontSize: 16),
                          cursorColor: AppColors.secondColor,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(FontAwesomeIcons.solidCircleUser,
                                color: AppColors.primaryColor),
                            hintText: "Enter your name".tr,
                            hintStyle: Get.textTheme.bodySmall,
                          ),
                          keyboardType: TextInputType.name)
                      .marginOnly(top: 15),
                  TextField(
                          controller: controller.emailContoller,
                          style: Get.textTheme.displayMedium!
                              .copyWith(fontSize: 16),
                          cursorColor: AppColors.secondColor,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                                color: AppColors.primaryColor),
                            hintText: "Enter your email address".tr,
                            hintStyle: Get.textTheme.bodySmall,
                          ),
                          keyboardType: TextInputType.emailAddress)
                      .marginOnly(top: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return TextButton(
                          onPressed: () => controller.loading.value
                              ? null
                              : controller.signup(),
                          child: controller.loading.value
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Text("SIGNUP".tr,
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(color: Colors.white)));
                    }),
                  ).marginOnly(top: 30, bottom: 30),
                ],
              )),
        ));
  }
}
