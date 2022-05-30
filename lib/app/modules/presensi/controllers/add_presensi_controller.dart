import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/shift_model.dart';
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
  List<ShiftModel> shifts = <ShiftModel>[].obs;
  final _selectedShift = ShiftModel().obs;
  ShiftModel get selectedShift => _selectedShift.value;
  set selectedShift(ShiftModel value) => _selectedShift.value = value;

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
    getShifts();
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

  void getShifts() async {
    Box<ShiftModel> box = Hive.box<ShiftModel>('shift');
    shifts = await box.values.toList();
  }

  void presensi() {
    Box<Kehadiran> box = Hive.box<Kehadiran>('kehadiran');
    var listPresensiCurrentUser = box.values
        .where((element) =>
            element.userId == selectedKaryawan.id &&
            element.shift?.id == selectedShift.id.toString() &&
            isToday(DateTime.parse(element.waktuKehadiran!)))
        .toList();

    // convers selected shift time to splitted date
    var selectedShiftStartTime = selectedShift.timeStart?.split(':');
    var selectedShiftEndTime = selectedShift.timeEnd?.split(':');

    // convers selected shift time to date time
    var shiftStart = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(selectedShiftStartTime![0]),
        int.parse(selectedShiftStartTime[1]));

    var shiftEnd =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(Duration(
      hours: int.parse(selectedShiftEndTime![0]),
      minutes: int.parse(selectedShiftEndTime[1]),
    ));

    if (listPresensiCurrentUser.length == 0) {
      Kehadiran data = Kehadiran(
        userId: selectedKaryawan.id,
        waktuKehadiran: DateTime.now().toString(),
        statusKehadiran: DateTime.now().isBefore(shiftStart)
            ? StatusKehadiran.TerlaluPagi
            : DateTime.now().isAfter(shiftEnd)
                ? StatusKehadiran.Terlambat
                : StatusKehadiran.Hadir,
        shift: ShiftModel(
            id: selectedShift.id.toString(),
            name: selectedShift.name.toString()),
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
