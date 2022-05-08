import 'package:get/get.dart';

import '../controllers/absen_input_controller.dart';

class AbsenInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsenInputController>(
      () => AbsenInputController(),
    );
  }
}
