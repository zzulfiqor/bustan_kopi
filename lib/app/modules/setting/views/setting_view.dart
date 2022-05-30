import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Pin Setting
          ListTile(
            leading: Icon(
              Icons.lock,
              color: Colors.brown,
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Colors.black,
            ),
            title: Text('Ubah PIN'),
            onTap: () {
              Get.toNamed(Routes.PIN, arguments: Routes.PIN_CHANGE);
            },
          ),

          // Setting Jam Masuk Shift
          ListTile(
            leading: Icon(
              Icons.punch_clock,
              color: Colors.brown,
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: Colors.black,
            ),
            title: Text('Ubah Waktu Shift'),
            onTap: () {
              Get.toNamed(Routes.SHIFT_EDIT);
            },
          ),
        ],
      ),
    );
  }
}
