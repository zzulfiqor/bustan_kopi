import 'dart:developer';
import 'dart:io';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddKaryawanController extends GetxController {
  // argument
  final _arguments = UserModel().obs;
  UserModel get arguments => _arguments.value;
  set arguments(UserModel value) => _arguments.value = value;
  final _currentDataIndex = 0.obs;
  int get currentDataIndex => _currentDataIndex.value;
  set currentDataIndex(int value) => _currentDataIndex.value = value;

  // Radio Group User Type
  final _radioValue = "".obs;
  String get radioValue => _radioValue.value;
  set radioValue(String value) => _radioValue.value = value;

  // Password Karyawan
  TextEditingController passwordKaryawanController = TextEditingController();
  final _passwordKaryawan = "".obs;
  String get passwordKaryawan => _passwordKaryawan.value;
  set passwordKaryawan(String value) => _passwordKaryawan.value = value;

  // Nama Karyawan
  TextEditingController namaKaryawanController = TextEditingController();
  final _namaKaryawan = ''.obs;
  String get namaKaryawan => _namaKaryawan.value;
  set namaKaryawan(String value) => _namaKaryawan.value = value;

  // Avatar Karyawan
  final _avatarKaryawanFile = File('').obs;
  File get avatarKaryawanFile => _avatarKaryawanFile.value;
  set avatarKaryawanFile(File value) => _avatarKaryawanFile.value = value;
  final _avatarKaryawan = ''.obs;
  String get avatarKaryawan => _avatarKaryawan.value;
  set avatarKaryawan(String value) => _avatarKaryawan.value = value;

  // Alamat Karyawan
  TextEditingController alamatKaryawanController = TextEditingController();
  final _alamatKaryawan = ''.obs;
  String get alamatKaryawan => _alamatKaryawan.value;
  set alamatKaryawan(String value) => _alamatKaryawan.value = value;

  // Email Karyawan
  TextEditingController emailKaryawanController = TextEditingController();
  final _emailKaryawan = ''.obs;
  String get emailKaryawan => _emailKaryawan.value;
  set emailKaryawan(String value) => _emailKaryawan.value = value;

  // Phone Karyawan
  TextEditingController phoneKaryawanController = TextEditingController();
  final _phoneKaryawan = ''.obs;
  String get phoneKaryawan => _phoneKaryawan.value;
  set phoneKaryawan(String value) => _phoneKaryawan.value = value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] != null) {
      arguments = Get.arguments[0];
      fillData();
    }

    if (Get.arguments[1] != null) {
      currentDataIndex = Get.arguments[1];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fillData() {
    namaKaryawanController.text = arguments.name ?? '';
    namaKaryawan = arguments.name ?? '';
    alamatKaryawanController.text = arguments.address ?? '';
    alamatKaryawan = arguments.address ?? '';
    emailKaryawanController.text = arguments.email ?? '';
    emailKaryawan = arguments.email ?? '';
    phoneKaryawanController.text = arguments.phone ?? '';
    phoneKaryawan = arguments.phone ?? '';
    avatarKaryawan = arguments.photoPath ?? '';
    radioValue = arguments.role ?? '';
    passwordKaryawanController.text = arguments.password ?? '';
    avatarKaryawanFile = File(avatarKaryawan);
  }

  void addKaryawanPhoto() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      avatarKaryawanFile = File(image.path);
      avatarKaryawan =
          '${appDocPath}/avatar_${DateTime.now().microsecondsSinceEpoch}.${image.path.split('.').last}';
    }

    log(image?.path ?? 'No image selected');
  }

  void setUserType(String value) {
    radioValue = value;
  }

  void saveAvatarKaryawan() async {
    if (avatarKaryawanFile.path != '') {
      await avatarKaryawanFile.copy(avatarKaryawan);
    } else {
      Get.rawSnackbar(message: 'Belum memilih foto');
    }
  }

  void submitKaryawan() async {
    // Check User Type Not Selected
    if (radioValue == '') {
      Get.rawSnackbar(message: 'Belum memilih tipe user');
      return;
    }

    // Check Password Not Empty
    if (passwordKaryawanController.text == '') {
      Get.rawSnackbar(message: 'Password tidak boleh kosong');
      return;
    }

    // Check nama is still blank
    if (namaKaryawan == '') {
      Get.rawSnackbar(message: 'Nama tidak boleh kosong');
      return;
    }

    // check alamat is still blank
    if (alamatKaryawan == '') {
      Get.rawSnackbar(message: 'Alamat tidak boleh kosong');
      return;
    }

    // check email is still blank
    if (emailKaryawan == '') {
      Get.rawSnackbar(message: 'Email tidak boleh kosong');
      return;
    }

    // check phone is still blank
    if (phoneKaryawan == '') {
      Get.rawSnackbar(message: 'No. Telp tidak boleh kosong');
      return;
    }

    // check avatar is still blank
    if (avatarKaryawan == '') {
      Get.rawSnackbar(message: 'Belum memilih foto');
      return;
    }

    // Save data
    var box = await Hive.openBox<UserModel>('user');

    UserModel data = UserModel(
      id: 'kry${DateTime.now().microsecondsSinceEpoch}',
      name: namaKaryawan,
      address: alamatKaryawan,
      email: emailKaryawan,
      phone: phoneKaryawan,
      photoPath: avatarKaryawan,
      password: passwordKaryawan,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      role: radioValue,
    );

    box.add(data).then((value) {
      saveAvatarKaryawan();
      Get.back();
      Get.rawSnackbar(message: 'Karyawan  berhasil ditambahkan');
    });
  }

  void editKaryawan() async {
    // Check User Type Not Selected
    if (radioValue == '') {
      Get.rawSnackbar(message: 'Belum memilih tipe user');
      return;
    }

    // Check Password Not Empty
    if (passwordKaryawanController.text == '') {
      Get.rawSnackbar(message: 'Password tidak boleh kosong');
      return;
    }

    // Check nama is still blank
    if (namaKaryawan == '') {
      Get.rawSnackbar(message: 'Nama tidak boleh kosong');
      return;
    }

    // check alamat is still blank
    if (alamatKaryawan == '') {
      Get.rawSnackbar(message: 'Alamat tidak boleh kosong');
      return;
    }

    // check email is still blank
    if (emailKaryawan == '') {
      Get.rawSnackbar(message: 'Email tidak boleh kosong');
      return;
    }

    // check phone is still blank
    if (phoneKaryawan == '') {
      Get.rawSnackbar(message: 'No. Telp tidak boleh kosong');
      return;
    }

    // check avatar is still blank
    if (avatarKaryawan == '') {
      Get.rawSnackbar(message: 'Belum memilih foto');
      return;
    }

    // Save data
    var box = await Hive.openBox<UserModel>('user');

    UserModel data = UserModel(
      id: arguments.id,
      name: namaKaryawan,
      address: alamatKaryawan,
      email: emailKaryawan,
      phone: phoneKaryawan,
      photoPath: avatarKaryawan,
      password: passwordKaryawan,
      createdAt: arguments.createdAt,
      updatedAt: DateTime.now().toString(),
      role: radioValue,
    );

    box.putAt(currentDataIndex, data).then((value) {
      saveAvatarKaryawan();
      Get.back();
      Get.rawSnackbar(message: 'Karyawan berhasil diedit');
    });
  }
}
