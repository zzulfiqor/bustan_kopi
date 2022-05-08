import 'dart:developer';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class PinController extends GetxController {
  // Route
  final _route = "".obs;
  String get route => this._route.value;
  set route(String value) => this._route.value = value;

  // pin
  final _pin = "".obs;
  String get pin => this._pin.value;
  set pin(String value) => this._pin.value = value;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // get routes from get arguments
    this.route = Get.arguments;

    // Hive Box
    var box = Hive.box<String>('pin');
    log(box.values.first);
    this.pin = box.values.first;
  }

  // submit pin
  void submitPin(String pin) {
    var splittedArg = this.route.split('/');
    var indexPresensi = "";
    if (splittedArg.length > 1) {
      indexPresensi = splittedArg[1];
    } else {
      indexPresensi = "";
    }

    if (pin == this.pin && splittedArg.first != 'delete') {
      Get.offNamed(route);
    } else if (pin == this.pin && splittedArg.first == 'delete') {
      var box = Hive.box<Kehadiran>('kehadiran');
      box.deleteAt(int.parse(indexPresensi));
      Get.back();
    } else {
      Get.snackbar('Pin Salah', 'Silahkan coba lagi');
    }
  }
}
