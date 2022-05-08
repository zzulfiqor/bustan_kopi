import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class ChangePinController extends GetxController {
  // pin
  final _pin = "".obs;
  String get pin => this._pin.value;
  set pin(String value) => this._pin.value = value;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  // submit pin
  void submitPin(String pin) {
    // Hive Box
    var box = Hive.box<String>('pin');
    box.clear().then((value) {
      box.add(pin).then((value) => Get.back());
    });
  }
}
