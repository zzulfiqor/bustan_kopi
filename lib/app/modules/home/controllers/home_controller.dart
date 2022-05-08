import 'dart:developer';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  // Current Active User
  final _currentUser = UserModel().obs;
  UserModel get currentUser => _currentUser.value;
  set currentUser(UserModel value) => _currentUser.value = value;

  // Karyawan
  final _jumlahKaryawan = 0.obs;
  int get jumlahKaryawan => this._jumlahKaryawan.value;
  set jumlahKaryawan(int value) => this._jumlahKaryawan.value = value;

  // Kehadiran Hari Ini
  final _kehadiranHariIni = 0.obs;
  int get kehadiranHariIni => this._kehadiranHariIni.value;
  set kehadiranHariIni(int value) => this._kehadiranHariIni.value = value;

  @override
  void onInit() {
    super.onInit();
    // set current user
    currentUser = Get.arguments;

    getKehadiranHariIni();
    getJumlahKarywan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getKehadiranHariIni() {
    var box = Hive.box<Kehadiran>('kehadiran');
    log(box.length.toString());
    kehadiranHariIni = box.length;
  }

  void getJumlahKarywan() {
    var box = Hive.box<UserModel>('user');
    log(box.length.toString());
    jumlahKaryawan = box.length;
  }

  void logout() {
    var box = Hive.box<UserModel>('activeUser');
    box.clear().then((value) {
      Future.delayed(Duration(milliseconds: 200), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    });
  }
}
