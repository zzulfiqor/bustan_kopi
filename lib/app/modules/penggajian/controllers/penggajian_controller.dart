import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PenggajianController extends GetxController {
  // Nominal Gaji
  TextEditingController nominalGajiController = TextEditingController();
  final _nominalGaji = 100000.obs;
  int get nominalGaji => this._nominalGaji.value;
  set nominalGaji(int value) => this._nominalGaji.value = value;

  @override
  void onInit() {
    super.onInit();
    var box = Hive.box<int>('nominalGaji');
    log(box.toMap().values.toList().toString());
    nominalGaji = box.toMap().values.toList().length > 0
        ? box.toMap().values.toList().first
        : 100000;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void setGaji() async {
    var box = Hive.box<int>('nominalGaji');
    nominalGaji = int.parse(nominalGajiController.text);
    box.putAt(0, nominalGaji);
    Get.back();
  }
}
