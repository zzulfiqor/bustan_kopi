import 'dart:io';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/status_kehadiran_enum.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:bustan_kopi/app/utils/global_function.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/presensi_controller.dart';

class PresensiView extends GetView<PresensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Karyawan'),
        centerTitle: true,
        actions: [
          // delete all
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Hapus Semua Data'),
                        content: Text(
                            'Apakah anda yakin akan menghapus semua data?'),
                        actions: [
                          ElevatedButton(
                            child: Text('Tidak'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                              child: Text('Ya'),
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PIN, arguments:'delete/all');
                              }),
                        ]);
                  });
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Kehadiran>('kehadiran').listenable(),
          builder: (context, Box<Kehadiran> box, widget) {
            var data = controller.currentUser.role == "Karyawan"
                ? box.values
                    .where((element) =>
                        element.userId == controller.currentUser.id)
                    .toList()
                : box.values.toList();
            return box.values.length != 0
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return ValueListenableBuilder(
                          valueListenable:
                              Hive.box<UserModel>('user').listenable(),
                          builder: (context, Box<UserModel> boxUser, _) {
                            var userData = boxUser.values
                                .where((element) =>
                                    element.id == data[index].userId)
                                .toList();

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Get.dialog(AlertDialog(
                                      title: Text('Hapus Data'),
                                      content: Text(
                                          'Apakah anda yakin ingin menghapus data ini?'),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('Tidak'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('Ya'),
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PIN,
                                                arguments: 'delete/$index');
                                          },
                                        ),
                                      ],
                                    ));
                                  },
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: FileImage(
                                      File('${userData[0].photoPath}'),
                                    ),
                                    backgroundColor: Colors.grey,
                                  ),
                                  title: Text(
                                      '${userData[0].name} (${data[index].shift?.name.toString()})'),
                                  subtitle: Text(
                                    formatDateToIndonesiaLengkap(
                                      DateTime.parse(
                                          data[index].waktuKehadiran ?? ''),
                                    ),
                                  ),
                                  trailing: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: data[index].statusKehadiran ==
                                              StatusKehadiran.TerlaluPagi
                                          ? Colors.amber
                                          : data[index].statusKehadiran ==
                                                  StatusKehadiran.Terlambat
                                              ? Colors.red
                                              : Colors.green,
                                    ),
                                    child: Icon(
                                      data[index].statusKehadiran ==
                                              StatusKehadiran.TerlaluPagi
                                          ? Icons.warning
                                          : data[index].statusKehadiran ==
                                                  StatusKehadiran.Terlambat
                                              ? Icons.close
                                              : Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(.5),
                                )
                              ],
                            );
                          });
                    }),
                  )
                : Center(
                    child: Text(
                      "Belum ada Presensi.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.PRESENSI_ADD);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
