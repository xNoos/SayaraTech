import 'dart:convert';
import 'dart:io';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/app/routes/app_pages.dart';
import 'package:sayaratech/app/service/app_colors.dart';
import 'package:sayaratech/app/service/app_images.dart';
import '../controllers/my_cars_controller.dart';

class MyCarsView extends GetView<MyCarsController> {
  const MyCarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyCarsController());
    return Obx(() {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 100.0,
              actions: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppPages.ADD_CAR)!
                      .then((_) => controller.getMyCars()),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white)),
                    child: const Icon(Icons.add),
                  ),
                ).marginSymmetric(horizontal: 10),
              ],
              title: Text(
                "My Cars".tr,
              ),
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: 52,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: Get.height,
              flexibleSpace: SmartRefresher(
                header: WaterDropHeader(
                    waterDropColor: AppColors.primaryColor,
                    complete: const Icon(
                      Icons.check,
                      size: 20,
                    )),
                enablePullDown: true,
                controller: controller.refreshController,
                onRefresh: () => controller.getMyCars(),
                child: ListView.builder(
                    itemCount: controller.myCars.length,
                    padding: EdgeInsets.only(
                        top: 15, bottom: Platform.isIOS ? 340 : 250),
                    itemBuilder: (_, index) {
                      return Container(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 10),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.greyColor.withOpacity(.1),
                                    blurRadius: 10,
                                    spreadRadius: 10)
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.greyColor.withOpacity(.3))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.myCars[index][
                                        Get.locale.toString() == "ar"
                                            ? 'Vendor_name'
                                            : 'Vendor_egn_name'],
                                    style: Get.textTheme.displaySmall,
                                  ),
                                  Image.memory(
                                    base64Decode(controller.myCars[index]
                                        ['Vendors_binary_image']),
                                    width: 80,
                                  )
                                ],
                              ).marginSymmetric(vertical: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.greyColor
                                            .withOpacity(.9))),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.saudiLogo,
                                      width: 30,
                                      color:
                                          AppColors.greyColor.withOpacity(.9),
                                    ).marginSymmetric(
                                        horizontal: 10, vertical: 5),
                                    Expanded(
                                        child: Text(
                                      controller.myCars[index]['Board_No'],
                                      textAlign: TextAlign.center,
                                    )),
                                    Image.asset(
                                      AppImages.saudiLogo,
                                      width: 30,
                                      color: Colors.transparent,
                                    ).marginSymmetric(
                                        horizontal: 10, vertical: 5),
                                  ],
                                ),
                              ).marginSymmetric(horizontal: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delete".tr),
                                  TextButton(
                                      onPressed: () => Get.toNamed(
                                                  AppPages.ADD_CAR,
                                                  arguments: {
                                                "carId": controller
                                                    .myCars[index]['id']
                                                    .toString()
                                              })!
                                              .then((_) =>
                                                  controller.getMyCars()),
                                      child: Text(
                                        "Edit".tr,
                                        style: Get.textTheme.bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15.0),
                                      ).paddingSymmetric(horizontal: 20))
                                ],
                              ).marginOnly(top: 10),
                            ],
                          ));
                    }),
              ),
            )
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {

            //     },
            //     childCount: controller.myCars.length,
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
