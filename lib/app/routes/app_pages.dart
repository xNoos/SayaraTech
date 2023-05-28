import 'package:get/get.dart';

import '../modules/add-car/bindings/add_car_binding.dart';
import '../modules/add-car/views/add_car_view.dart';
import '../modules/bookings/bindings/bookings_binding.dart';
import '../modules/bookings/views/bookings_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main-screen/bindings/main_screen_binding.dart';
import '../modules/main-screen/views/main_screen_view.dart';
import '../modules/my-cars/bindings/my_cars_binding.dart';
import '../modules/my-cars/views/my_cars_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const HOME = Routes.HOME;
  static const MAIN_SCREEN = Routes.MAIN_SCREEN;
  static const LOGIN = Routes.LOGIN;
  static const SIGNUP = Routes.SIGNUP;
  static const PROFILE = Routes.PROFILE;
  static const MY_CARS = Routes.MY_CARS;
  static const VIEW_CAR = Routes.VIEW_CAR;
  static const EDIT_CAR = Routes.EDIT_CAR;
  static const ADD_CAR = Routes.ADD_CAR;
  static const OTP = Routes.OTP;
  static const BOOKINGS = Routes.BOOKINGS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MY_CARS,
      page: () => const MyCarsView(),
      binding: MyCarsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CAR,
      page: () => const AddCarView(),
      binding: AddCarBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingsBinding(),
    ),
  ];
}
