import 'package:get/get.dart';

import 'package:bustan_kopi/app/modules/pin/controllers/change_pin_controller.dart';

import '../controllers/pin_controller.dart';

class PinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePinController>(
      () => ChangePinController(),
    );
    Get.lazyPut<PinController>(
      () => PinController(),
    );
  }
}
