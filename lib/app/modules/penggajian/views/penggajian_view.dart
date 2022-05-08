import 'dart:io';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/penggajian_controller.dart';

class PenggajianView extends GetView<PenggajianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penggajian'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // set nominalGaji
              controller.nominalGajiController.text =
                  controller.nominalGaji.toString();
              Get.bottomSheet(
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Nominal Gaji',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: controller.nominalGajiController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Nominal Gaji',
                        ),
                      ),

                      // Button
                      HeightBox(16),
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: ElevatedButton(
                          child: Text('Simpan'),
                          onPressed: () {
                            controller.setGaji();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<UserModel>('user').listenable(),
          builder: (context, Box<UserModel> box, _) {
            var data = box.values
                .where((element) => element.role == "Karyawan")
                .toList();
            return data.length == 0
                ? Center(
                    child: "Belum ada data penggajian".text.makeCentered(),
                  )
                : ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Kehadiran>('kehadiran').listenable(),
                    builder:
                        (contextKehadiran, Box<Kehadiran> boxKehadiran, __) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          var dataJumlahKehadiran = boxKehadiran.values
                              .where(
                                  (element) => element.userId == data[index].id)
                              .toList()
                              .length;
                          return Obx(
                            () => Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: FileImage(
                                      File('${data[index].photoPath}'),
                                    ),
                                    backgroundColor: Colors.grey,
                                  ),
                                  title: "${data[index].name}"
                                      .text
                                      .size(18)
                                      .bold
                                      .make(),
                                  subtitle: "$dataJumlahKehadiran Kehadiran"
                                      .text
                                      .size(16)
                                      .make(),
                                  trailing:
                                      "Rp. ${controller.nominalGaji * dataJumlahKehadiran}"
                                          .text
                                          .bold
                                          .size(16)
                                          .make(),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
