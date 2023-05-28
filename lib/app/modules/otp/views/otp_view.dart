import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../../../service/app_colors.dart';
import '../../../service/app_images.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
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
                  "Verification".tr,
                  style: Get.textTheme.displayMedium!.copyWith(fontSize: 40.0),
                ).marginOnly(top: 80),
                Center(
                  child: Text(
                    "Code has been sent to your phone".tr,
                  ),
                ).marginOnly(top: 20),
                Center(
                  child: Text(
                    textDirection: TextDirection.ltr,
                    "+966 ${controller.data['mobile']}",
                  ),
                ).marginOnly(top: 10),
                Text(
                  "Code".tr,
                  style: Get.textTheme.displaySmall,
                ).marginOnly(top: 50, bottom: 10),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Form(
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textInputAction: TextInputAction.done,
                      appContext: context,
                      length: 4,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 60,
                        fieldWidth: 50,
                        selectedFillColor:
                            AppColors.primaryColor.withOpacity(.3),
                        activeColor: AppColors.primaryColor,
                        selectedColor: AppColors.primaryColor,
                        inactiveFillColor: Colors.white,
                        inactiveColor: AppColors.primaryColor.withOpacity(.5),
                        activeFillColor: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      cursorColor: Colors.transparent,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: Get.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900),
                      enableActiveFill: true,
                      controller: controller.codeContoller,
                      keyboardType: TextInputType.number,
                      onCompleted: (code) => controller.sendOtp(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.timer.value > 0
                      ? null
                      : controller.resendCode(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Resend Code'.tr,
                          style: TextStyle(color: AppColors.primaryColor)),
                      Obx(() {
                        return Visibility(
                          visible: controller.timer.value > 0,
                          child: Text(' (${controller.timer.value})',
                              style: TextStyle(color: AppColors.primaryColor)),
                        );
                      }),
                    ],
                  ),
                ).marginOnly(top: 50, bottom: 30)
              ],
            )));
  }
}
