import 'dart:io';

import 'package:bustan_kopi/app/modules/presensi/controllers/add_presensi_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddPresensiView extends GetView<AddPresensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Presensi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select Karyawan
              HeightBox(24),
              VStack([
                Text('Pilih Karyawan').text.size(16).bold.make(),
                HeightBox(8),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          // Header
                          HeightBox(16),
                          "Pilih Karyawan".text.headline6(context).make(),

                          // List Karyawan
                          HeightBox(26),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.listKaryawan.length,
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundImage: FileImage(File(controller
                                              .listKaryawan[index].photoPath ??
                                          '')),
                                      backgroundColor: Colors.grey,
                                    ),
                                    title: Text(
                                        controller.listKaryawan[index].name ??
                                            ''),
                                    onTap: () {
                                      controller.selectedKaryawan =
                                          controller.listKaryawan[index];
                                      Get.back();
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => HStack([
                              controller.selectedKaryawan.id == null
                                  ? Container()
                                  : CircleAvatar(
                                      radius: 24,
                                      backgroundImage: FileImage(File(controller
                                              .selectedKaryawan.photoPath ??
                                          '')),
                                      backgroundColor: Colors.grey,
                                    ),
                              WidthBox(16),
                              Text(
                                  "${controller.selectedKaryawan.name ?? 'Pilih Karyawan'}"),
                            ])),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ]),

              // Select Shift
              HeightBox(24),
              VStack([
                Text('Pilih Shift').text.size(16).bold.make(),
                HeightBox(8),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          // Header
                          HeightBox(16),
                          "Pilih Shift".text.headline6(context).make(),

                          // List Karyawan
                          HeightBox(26),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.shifts.length,
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    leading: Icon(Icons.access_time),
                                    title: Text(
                                        "Shift Ke - ${controller.shifts[index].id}"),
                                    subtitle:
                                        "${controller.shifts[index].timeStart} - ${controller.shifts[index].timeEnd} WIB"
                                            .text
                                            .make(),
                                    onTap: () {
                                      controller.selectedShift =
                                          controller.shifts[index];
                                      Get.back();
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HStack([
                          Obx(() => Text(
                              "${controller.selectedShift.id == null ? 'Pilih Shift' : 'Shift Ke - ' + controller.selectedShift.id.toString() + ' ( ${controller.selectedShift.timeStart} - ${controller.selectedShift.timeEnd} WIB) '}")),
                        ]).paddingOnly(left: 16),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ]),

              // Button Presensi Sekarang
              HeightBox(24),
              SizedBox(
                height: 50,
                width: Get.width,
                child: Obx(() => ElevatedButton(
                    onPressed: controller.selectedKaryawan.id != null &&
                            controller.selectedShift != 0
                        ? () {
                            controller.presensi();
                          }
                        : null,
                    child: "Presensi Sekarang".text.bold.make())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
