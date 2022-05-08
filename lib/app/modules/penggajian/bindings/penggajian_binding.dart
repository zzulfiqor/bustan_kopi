import 'package:get/get.dart';

import '../controllers/penggajian_controller.dart';

class PenggajianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PenggajianController>(
      () => PenggajianController(),
    );
  }
}
