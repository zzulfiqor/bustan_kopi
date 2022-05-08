import 'package:get/get.dart';

import 'package:bustan_kopi/app/modules/presensi/controllers/add_presensi_controller.dart';

import '../controllers/presensi_controller.dart';

class PresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPresensiController>(
      () => AddPresensiController(),
    );
    Get.lazyPut<PresensiController>(
      () => PresensiController(),
    );
  }
}
