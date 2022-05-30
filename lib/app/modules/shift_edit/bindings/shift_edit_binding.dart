import 'package:bustan_kopi/app/modules/shift_edit/controllers/shift_edit_dialog_controller.dart';
import 'package:get/get.dart';

import '../controllers/shift_edit_controller.dart';

class ShiftEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftEditController>(
      () => ShiftEditController(),
    );
    Get.lazyPut<ShiftEditDialogController>(
      () => ShiftEditDialogController(),
      fenix: true,
    );
  }
}
