import 'package:get/get.dart';

import 'package:bustan_kopi/app/modules/karyawan/controllers/add_karyawan_controller.dart';

import '../controllers/karyawan_controller.dart';

class KaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKaryawanController>(
      () => AddKaryawanController(),
    );
    Get.lazyPut<KaryawanController>(
      () => KaryawanController(),
    );
  }
}
