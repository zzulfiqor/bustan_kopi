import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/status_kehadiran_enum.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/utils/global_function.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class AddPresensiController extends GetxController {
  // User
  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  // Selected Shift
  List<int> shifts = [1, 2];
  final _selectedShift = 0.obs;
  int get selectedShift => _selectedShift.value;
  set selectedShift(int value) => _selectedShift.value = value;

  // List Karyawan
  final _listKaryawan = <UserModel>[UserModel(name: '')].obs;
  List<UserModel> get listKaryawan => _listKaryawan;
  set listKaryawan(List<UserModel> value) => _listKaryawan.value = value;

  // Selected Karyawan
  final _selectedKaryawan = UserModel().obs;
  UserModel get selectedKaryawan => _selectedKaryawan.value;
  set selectedKaryawan(UserModel value) => _selectedKaryawan.value = value;

  @override
  void onInit() {
    super.onInit();
    getKaryawan();

    var box = Hive.box<UserModel>('activeUser');
    if (box.values.length > 0) {
      var activeUser = box.toMap().values.toList().first;
      user = activeUser;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getKaryawan() async {
    Box<UserModel> box = Hive.box<UserModel>('user');
    listKaryawan = await box.values
        .where((element) => element.role == 'Karyawan')
        .toList();
  }

  void presensi() {
    Box<Kehadiran> box = Hive.box<Kehadiran>('kehadiran');
    var listPresensiCurrentUser = box.values
        .where((element) =>
            element.userId == selectedKaryawan.id &&
            element.shift == selectedShift.toString() &&
            isToday(DateTime.parse(element.waktuKehadiran!)))
        .toList();

    if (listPresensiCurrentUser.length == 0) {
      Kehadiran data = Kehadiran(
        userId: selectedKaryawan.id,
        waktuKehadiran: DateTime.now().toString(),
        statusKehadiran: StatusKehadiran.Hadir,
        shift: selectedShift.toString(),
      );

      box.add(data).then((value) {
        Get.back();
        Get.rawSnackbar(message: 'Presensi Berhasil');
      });
    } else {
      // Anda sudah melakukan presensi
      Get.rawSnackbar(message: 'Anda sudah melakukan presensi');
    }
  }
}
