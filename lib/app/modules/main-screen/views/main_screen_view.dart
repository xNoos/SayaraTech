import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (i) => controller.index.value = i,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.house_fill),
                    label: "Home".tr),
                BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.square_list_fill),
                    label: "Bookings".tr),
                BottomNavigationBarItem(
                    icon: const Icon(FontAwesomeIcons.car), label: "Cars".tr),
                BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.person_fill),
                    label: "Profile".tr),
              ]),
          body: controller.pages[controller.index.value]);
    });
  }
}
