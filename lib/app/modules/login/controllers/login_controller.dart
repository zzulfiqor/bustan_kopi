import 'dart:developer';

import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginController extends GetxController {
  // Super User
  final _superUser = UserModel(
    id: 'super-001',
    email: 'superAdmin',
    password: 'superAdmin123',
    name: 'Super Admin',
    role: 'Admin',
    photoPath: 'assets/images/super-admin.jpg',
  ).obs;
  UserModel get superUser => _superUser.value;
  set superUser(UserModel value) => _superUser.value = value;

  // Email
  final emailController = TextEditingController();
  final _email = ''.obs;
  String get email => this._email.value;
  set email(String value) => this._email.value = value;

  // Password
  final passwordController = TextEditingController();
  final _password = ''.obs;
  String get password => this._password.value;
  set password(String value) => this._password.value = value;

  @override
  void onInit() {
    super.onInit();
    var box = Hive.box<UserModel>('activeUser');
    var boxPin = Hive.box<String>('pin');

    // if boxPin empty
    if (boxPin.values.length == 0) {
      boxPin.add('123456');
    }

    if (box.values.length > 0) {
      var activeUser = box.toMap().values.toList().first;
      Future.delayed(Duration(milliseconds: 100), () {
        Get.offAllNamed(Routes.HOME, arguments: activeUser);
      });
    }
  }

  @override
  void onClose() {}

  // login process
  void loginProcess() {
    print('login process $email | $password');
    var box = Hive.box<UserModel>('user');
    var userList = box.values
        .where(
            (element) => element.email == email && element.password == password)
        .toList();

    var user = userList.isEmpty ? UserModel() : userList.first;

    if (email == superUser.email && password == superUser.password) {
      var box = Hive.box<UserModel>('activeUser');
      box.add(superUser);
      Get.offAllNamed(Routes.HOME, arguments: superUser);
    } else if (email == user.email && password == user.password) {
      Get.offAllNamed(Routes.HOME, arguments: user);
      var box = Hive.box<UserModel>('activeUser');
      box.add(user);
    } else {
      Get.rawSnackbar(
          title: 'Login Gagal',
          message: 'Email atau Password Salah',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
