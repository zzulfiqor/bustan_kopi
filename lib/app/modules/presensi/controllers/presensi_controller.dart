import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class PresensiController extends GetxController {
  // current User
  final _currentUser = UserModel().obs;
  UserModel get currentUser => this._currentUser.value;
  set currentUser(UserModel value) => this._currentUser.value = value;

  @override
  void onInit() {
    super.onInit();
    var box = Hive.box<UserModel>('activeUser');
    if (box.values.length > 0) {
      var activeUser = box.toMap().values.toList().first;
      currentUser = activeUser;
    }
  }

  // delete All Presensi
  void deleteAllPresensi() {
    var box = Hive.box<Kehadiran>('kehadiran');
    box.clear();
  }
}
