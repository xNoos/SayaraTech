import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/app/modules/bookings/views/bookings_view.dart';
import 'package:sayaratech/app/modules/home/views/home_view.dart';
import 'package:sayaratech/app/modules/my-cars/views/my_cars_view.dart';
import 'package:sayaratech/app/modules/profile/views/profile_view.dart';

class MainScreenController extends GetxController {
  RxInt index = 0.obs;
  List<Widget> pages = const [
    HomeView(),
    BookingsView(),
    MyCarsView(),
    ProfileView()
  ];
}
