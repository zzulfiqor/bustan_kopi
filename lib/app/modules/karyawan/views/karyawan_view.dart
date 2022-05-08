import 'dart:io';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../controllers/karyawan_controller.dart';

class KaryawanView extends GetView<KaryawanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karyawan'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<UserModel>('user').listenable(),
          builder: (context, Box<UserModel> box, widget) {
            var data = box.values.toList();
            return box.values.length != 0
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: FileImage(
                            File('${data[index].photoPath}'),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        title:
                            Text('${data[index].name} (${data[index].role})'),
                        subtitle: Text('${data[index].email}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Delete
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
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
                                        // Delete Presensi that attached to this Karyawan
                                        var boxKehadiran =
                                            Hive.box<Kehadiran>('kehadiran');
                                        var listDeletedPresensi = [];
                                        boxKehadiran
                                            .toMap()
                                            .forEach((key, value) {
                                          if (value.userId == data[index].id) {
                                            listDeletedPresensi.add(key);
                                          }
                                        });

                                        listDeletedPresensi.forEach((element) {
                                          boxKehadiran.delete(element);
                                        });

                                        // Delete Avatar From Disk
                                        File file =
                                            File('${data[index].photoPath}');
                                        file.delete();

                                        // Delete Karyawan
                                        box.deleteAt(index);

                                        Get.back();
                                      },
                                    ),
                                  ],
                                ));
                              },
                            ),

                            // Edit
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Get.toNamed(Routes.KARYAWAN_ADD,
                                    arguments: [data[index], index]);
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                : Center(
                    child: Text("Belum ada karyawan."),
                  );
          }),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.KARYAWAN_ADD, arguments: [null, null]);
          }),
    );
  }
}
