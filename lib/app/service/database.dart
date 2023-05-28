import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sayaratech/app/service/translation_service.dart';

class Database {
  static String serverUrl = "https://satc.live/api/";

  static Map<String, String> header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'lng': Get.find<TranslationService>().getLocale().languageCode
  };

  static Map<String, String> headerWithToken = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': GetStorage().read("token") ?? "",
    'lng': Get.find<TranslationService>().getLocale().languageCode
  };
  static Map<String, String> headerRefreshToken = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'token': GetStorage().read("token") ?? "",
    'lng': Get.find<TranslationService>().getLocale().languageCode
  };

  static const String login = "Auth/Token/AuthenticateBySMSStep1";
  static const String loginOtp = "Auth/Token/AuthenticateBySMSStep2";

  static const String signup = "General/Customers/NewRegistrationStep1";
  static const String signupOtp = "General/Customers/NewRegistrationStep2";

  static const String profile = "Customer/Profile";
  static const String refreshToken = "Auth/Token/refreshToken";

  static const String getAllCars = "Customer/Cars";
  static const String getOneCar = "customer/Car";
  static const String updateCar = "Customer/UpdaetCar";
  static const String addCar = "Customer/AddCar";

  static const String getModelsEngine = "General/Cars/Models/Cylinder/";
  static const String getFuelTypes = "General/Cars/FuelTypes";
  static const String getColors = "General/Cars/Colors";
  static const String getModels = "General/Cars/Models";
  static const String getVendors = "General/Cars/Vendors";
}
