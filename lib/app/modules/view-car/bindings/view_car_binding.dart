import 'package:get/get.dart';

import '../controllers/view_car_controller.dart';

class ViewCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewCarController>(
      () => ViewCarController(),
    );
  }
}
