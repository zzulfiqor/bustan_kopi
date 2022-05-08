import 'package:bustan_kopi/app/modules/pin/views/change_pin_view.dart';
import 'package:get/get.dart';

import 'package:bustan_kopi/app/modules/absen_input/bindings/absen_input_binding.dart';
import 'package:bustan_kopi/app/modules/absen_input/views/absen_input_view.dart';
import 'package:bustan_kopi/app/modules/admin/bindings/admin_binding.dart';
import 'package:bustan_kopi/app/modules/admin/views/admin_view.dart';
import 'package:bustan_kopi/app/modules/home/bindings/home_binding.dart';
import 'package:bustan_kopi/app/modules/home/views/home_view.dart';
import 'package:bustan_kopi/app/modules/karyawan/bindings/karyawan_binding.dart';
import 'package:bustan_kopi/app/modules/karyawan/views/add_karyawan_view.dart';
import 'package:bustan_kopi/app/modules/karyawan/views/karyawan_view.dart';
import 'package:bustan_kopi/app/modules/login/bindings/login_binding.dart';
import 'package:bustan_kopi/app/modules/login/views/login_view.dart';
import 'package:bustan_kopi/app/modules/penggajian/bindings/penggajian_binding.dart';
import 'package:bustan_kopi/app/modules/penggajian/views/penggajian_view.dart';
import 'package:bustan_kopi/app/modules/pin/bindings/pin_binding.dart';
import 'package:bustan_kopi/app/modules/pin/views/pin_view.dart';
import 'package:bustan_kopi/app/modules/presensi/bindings/presensi_binding.dart';
import 'package:bustan_kopi/app/modules/presensi/views/add_presensi_view.dart';
import 'package:bustan_kopi/app/modules/presensi/views/presensi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_INPUT,
      page: () => AbsenInputView(),
      binding: AbsenInputBinding(),
    ),
    GetPage(
      name: _Paths.KARYAWAN,
      page: () => KaryawanView(),
      binding: KaryawanBinding(),
    ),
    GetPage(
      name: _Paths.KARYAWAN_ADD,
      page: () => AddKaryawanView(),
      binding: KaryawanBinding(),
    ),
    GetPage(
      name: _Paths.PENGGAJIAN,
      page: () => PenggajianView(),
      binding: PenggajianBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI,
      page: () => PresensiView(),
      binding: PresensiBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI_ADD,
      page: () => AddPresensiView(),
      binding: PresensiBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => PinView(),
      binding: PinBinding(),
    ),
    GetPage(
      name: _Paths.PIN_CHANGE,
      page: () => ChangePinView(),
      binding: PinBinding(),
    ),
  ];
}
