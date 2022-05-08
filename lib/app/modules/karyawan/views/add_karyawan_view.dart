import 'package:bustan_kopi/app/modules/karyawan/controllers/add_karyawan_controller.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddKaryawanView extends GetView<AddKaryawanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.arguments.id == null
              ? Text('Input Data Karyawan Baru')
              : Text('Edit Data Karyawan'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  HeightBox(24),
                  Stack(
                    children: [
                      // Avatar
                      controller.avatarKaryawan == ''
                          ? CircleAvatar(
                              radius: 48,
                              backgroundImage:
                                  AssetImage('assets/images/dummy_avatar.jpg'),
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              radius: 48,
                              backgroundImage:
                                  FileImage(controller.avatarKaryawanFile),
                              backgroundColor: Colors.grey,
                            ),

                      // Plus Icon / Add Avatar
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller.addKaryawanPhoto();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).centered(),

                  // Nama Karyawan TextField
                  HeightBox(32),
                  TextField(
                    controller: controller.namaKaryawanController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (val) {
                      controller.namaKaryawan = val;
                    },
                  ),

                  // Alamat Karyawan
                  HeightBox(24),
                  TextField(
                    controller: controller.alamatKaryawanController,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (val) {
                      controller.alamatKaryawan = val;
                    },
                  ),

                  // No. Telp Karyawan
                  HeightBox(24),
                  TextField(
                    controller: controller.phoneKaryawanController,
                    decoration: InputDecoration(
                      labelText: 'No. Telp',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (val) {
                      controller.phoneKaryawan = val;
                    },
                  ),

                  // Email Karyawan
                  HeightBox(24),
                  TextField(
                    controller: controller.emailKaryawanController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (val) {
                      controller.emailKaryawan = val;
                    },
                  ),

                  // Password Karyawan
                  HeightBox(24),
                  TextField(
                    controller: controller.passwordKaryawanController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (val) {
                      controller.passwordKaryawan = val;
                    },
                  ),

                  // User Type
                  HeightBox(24),
                  "Jenis User".text.size(18).make(),
                  RadioGroup<String>.builder(
                    direction: Axis.horizontal,
                    horizontalAlignment: MainAxisAlignment.start,
                    groupValue: controller.radioValue,
                    onChanged: (value) => controller.setUserType(value!),
                    items: ["Admin", "Karyawan"],
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),

                  // Button
                  HeightBox(32),
                  SizedBox(
                    height: 50,
                    width: Get.width,
                    child: Obx(() => ElevatedButton(
                          onPressed: () {
                            if (controller.arguments.id == null) {
                              controller.submitKaryawan();
                            } else {
                              controller.editKaryawan();
                            }
                          },
                          child: controller.arguments.id == null
                              ? 'Tambahkan Karyawan'.text.white.make()
                              : 'Ubah Data Karyawan'.text.white.make(),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
