import 'dart:io';

import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:bustan_kopi/app/routes/app_pages.dart';
import 'package:bustan_kopi/app/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header / Appbar
            HeightBox(16),
            Obx(() => HStack(
                  [
                    // Greetings
                    VStack([
                      'Selamat Datang,'.text.make(),
                      '${controller.currentUser.name}'
                          .text
                          .headline6(context)
                          .bold
                          .make(),
                    ]).expand(),

                    // Profile Picture
                    GestureDetector(
                      onTap: () {
                        // Show Logout Bottom Sheet
                        Get.bottomSheet(Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header
                                    HeightBox(16),
                                    "More".text.headline6(context).make(),

                                    // Elevated Button Height 50, width full                                    HeightBox(16),
                                    HeightBox(16),
                                    SizedBox(
                                      height: 50,
                                      width: Get.width,
                                      child: ElevatedButton(
                                        child: "Ganti Pin".text.make(),
                                        onPressed: () {
                                          Get.toNamed(Routes.PIN,
                                              arguments: Routes.PIN_CHANGE);
                                        },
                                      ),
                                    ),

                                    // Elevated Button Height 50, width full
                                    HeightBox(16),
                                    SizedBox(
                                      height: 50,
                                      width: Get.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Logout
                                          controller.logout();
                                          // Navigate to Login Page
                                          Get.offAllNamed(Routes.LOGIN);
                                        },
                                        child: "Logout".text.make(),
                                      ),
                                    ),
                                  ]),
                            )));
                      },
                      child: controller.currentUser.name == "Super Admin"
                          ? CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                (controller.currentUser.photoPath!),
                              ),
                            )
                          : CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey,
                              backgroundImage: FileImage(
                                  File(controller.currentUser.photoPath ?? '')),
                            ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16)),

            // Dashboard
            HeightBox(16),
            controller.currentUser.role == 'Admin'
                ? VStack(
                    [
                      // Tanggal Hari Ini
                      '${formatDateToIndonesia(
                        DateTime.now(),
                      )}'
                          .text
                          .size(20)
                          .bold
                          .white
                          .makeCentered(),

                      // Divider
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),

                      HStack(
                        [
                          // Kehadiran Hari Ini
                          VStack(
                            [
                              'Kehadiran Hari Ini'.text.white.make(),
                              ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box<Kehadiran>('kehadiran')
                                          .listenable(),
                                  builder: (context, Box<Kehadiran> box, _) {
                                    var data = box.values
                                        .where((element) =>
                                            (DateTime.parse(element
                                                            .waktuKehadiran ??
                                                        '')
                                                    .day ==
                                                DateTime.now().day) &&
                                            (DateTime.parse(element
                                                            .waktuKehadiran ??
                                                        '')
                                                    .month ==
                                                DateTime.now().month))
                                        .toList();
                                    return '${data.length}'
                                        .text
                                        .bold
                                        .white
                                        .makeCentered();
                                  }),
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ).expand(),

                          // Jumlah Karyawan
                          VStack(
                            [
                              'Jumlah Karyawan'.text.white.make(),
                              ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box<UserModel>('user').listenable(),
                                  builder: (context, Box<UserModel> box, _) {
                                    controller.jumlahKaryawan = box.values
                                        .where((element) =>
                                            element.role == "Karyawan")
                                        .length;
                                    return '${controller.jumlahKaryawan}'
                                        .text
                                        .bold
                                        .white
                                        .makeCentered();
                                  }),
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ).expand(),
                        ],
                        alignment: MainAxisAlignment.spaceEvenly,
                      ).marginOnly(top: 12, bottom: 12),
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                  )
                    .box
                    .gradientFromTo(
                        from: Colors.brown, to: Colors.brown.shade600)
                    .width(Get.width)
                    .p8
                    .margin(
                      EdgeInsets.symmetric(horizontal: 16),
                    )
                    .roundedSM
                    .make()

                // If Karyawan
                : VStack(
                    [
                      // Tanggal Hari Ini
                      '${formatDateToIndonesia(
                        DateTime.now(),
                      )}'
                          .text
                          .size(20)
                          .bold
                          .white
                          .makeCentered(),

                      // Divider
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),

                      HStack(
                        [
                          // Kehadiran Hari Ini
                          "Status Absen Hari Ini :"
                              .text
                              .white
                              .size(16)
                              .bold
                              .make()
                              .expand(),

                          // Status Absen Hari Ini
                          ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<Kehadiran>('kehadiran').listenable(),
                              builder: (context, Box<Kehadiran> box, _) {
                                return ValueListenableBuilder(
                                    valueListenable: Hive.box<UserModel>('user')
                                        .listenable(),
                                    builder: (contextUser,
                                        Box<UserModel> boxUser, __) {
                                      var dataTodayAbsen = box.values.where(
                                          (element) =>
                                              (DateTime.parse(element
                                                              .waktuKehadiran ??
                                                          '')
                                                      .day ==
                                                  DateTime.now().day) &&
                                              (DateTime.parse(element
                                                              .waktuKehadiran ??
                                                          '')
                                                      .month ==
                                                  DateTime.now().month));

                                      var listPresensiUserToday =
                                          dataTodayAbsen.where((element) =>
                                              element.userId ==
                                              controller.currentUser.id);

                                      bool? statusAbsen =
                                          listPresensiUserToday.isNotEmpty
                                              ? true
                                              : false;

                                      return Container(
                                        child: HStack([
                                          "${statusAbsen ? 'Sudah Presensi' : 'Belum Presensi'}"
                                              .text
                                              .size(16)
                                              .white
                                              .make(),

                                          // If presensi
                                          WidthBox(6),
                                          statusAbsen
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )
                                              : Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                        ]),
                                      );
                                    });
                              })
                        ],
                        alignment: MainAxisAlignment.spaceEvenly,
                      )
                          .marginOnly(top: 12, bottom: 12)
                          .paddingSymmetric(horizontal: 16),
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                  )
                    .box
                    .gradientFromTo(
                        from: Colors.brown, to: Colors.brown.shade600)
                    .width(Get.width)
                    .p8
                    .margin(
                      EdgeInsets.symmetric(horizontal: 16),
                    )
                    .roundedSM
                    .make(),

            // Admin Panel
            VStack(
              [
                HeightBox(22),

                "Panel Admin".text.headline6(context).make(),

                // Admin Panel Items
                HeightBox(16),
                HStack(
                  [
                    // Presensi
                    VStack(
                      [
                        Image.asset(
                          'assets/images/ic_presensi.png',
                          width: 42,
                        ),
                        'Presensi'.text.make().marginOnly(top: 8),
                      ],
                      alignment: MainAxisAlignment.center,
                      crossAlignment: CrossAxisAlignment.center,
                    ).onTap(() {
                      if (controller.jumlahKaryawan == 0) {
                        Get.rawSnackbar(
                          title: 'Peringatan',
                          message:
                              'Tidak Bisa Melakukan Presensi, Tidak ada karyawan yang terdaftar',
                          backgroundColor: Colors.red,
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        Get.toNamed(Routes.PRESENSI);
                      }
                    }),

                    // Karyawan
                    WidthBox(16),
                    VStack(
                      [
                        Image.asset(
                          'assets/images/ic_karyawan.png',
                          width: 42,
                        ),
                        'Karyawan'.text.make().marginOnly(top: 8),
                      ],
                      alignment: MainAxisAlignment.center,
                      crossAlignment: CrossAxisAlignment.center,
                    ).onTap(() {
                      Get.toNamed(Routes.PIN, arguments: Routes.KARYAWAN);
                    }),

                    // Penggajian
                    WidthBox(16),
                    VStack(
                      [
                        Image.asset(
                          'assets/images/ic_gaji.png',
                          width: 42,
                        ),
                        'Penggajian'.text.make().marginOnly(top: 8),
                      ],
                      alignment: MainAxisAlignment.center,
                      crossAlignment: CrossAxisAlignment.center,
                    ).onTap(() {
                      Get.toNamed(Routes.PIN, arguments: Routes.PENGGAJIAN);
                    })
                  ],
                ),
              ],
            ).pSymmetric(h: 16),

            // Presensi Hari Ini
            HeightBox(22),
            VStack(
              [
                // title
                HStack(
                  [
                    controller.currentUser.role == "Karyawan"
                        ? "Presensi Akunmu"
                            .text
                            .headline6(context)
                            .make()
                            .expand()
                        : "Presensi Hari Ini"
                            .text
                            .headline6(context)
                            .make()
                            .expand(),
                    "Lihat Semua"
                        .text
                        .bodyText2(context)
                        .blue500
                        .make()
                        .onTap(() {
                      Get.toNamed(Routes.PRESENSI);
                    }),
                  ],
                ),

                // Items
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Kehadiran>('kehadiran').listenable(),
                    builder: (context, Box<Kehadiran> box, widget) {
                      var data = controller.currentUser.role == "Karyawan"
                          ? box.values
                              .where((element) =>
                                  (DateTime.parse(element.waktuKehadiran ?? '')
                                          .day ==
                                      DateTime.now().day) &&
                                  (DateTime.parse(element.waktuKehadiran ?? '')
                                          .month ==
                                      DateTime.now().month) &&
                                  element.userId == controller.currentUser.id)
                              .toList()
                          : box.values
                              .where((element) =>
                                  (DateTime.parse(element.waktuKehadiran ?? '')
                                          .day ==
                                      DateTime.now().day) &&
                                  (DateTime.parse(element.waktuKehadiran ?? '')
                                          .month ==
                                      DateTime.now().month))
                              .toList();
                      return data.length != 0
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return ValueListenableBuilder(
                                    valueListenable: Hive.box<UserModel>('user')
                                        .listenable(),
                                    builder:
                                        (context, Box<UserModel> boxUser, _) {
                                      var userData = boxUser.values
                                          .where((element) =>
                                              element.id == data[index].userId)
                                          .toList();

                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              radius: 28,
                                              backgroundImage: FileImage(
                                                File(
                                                    '${userData[0].photoPath}'),
                                              ),
                                              backgroundColor: Colors.grey,
                                            ),
                                            title: Text(
                                                '${userData[0].name} (Shift ${data[index].shift})'),
                                            subtitle: Text(
                                              formatDateToIndonesiaLengkap(
                                                DateTime.parse(data[index]
                                                        .waktuKehadiran ??
                                                    ''),
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.check,
                                              color: Colors.green,
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 24,
                                ),
                                child: Text(
                                  "Belum ada Presensi Hari Ini.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                    }),
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),

      // fab if karyawan
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.PRESENSI_ADD);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.5),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                )
              ]),
          child: HStack([
            "Presensi".text.bodyText2(context).white.make(),
            Icon(
              Icons.add,
              color: Colors.white,
            )
          ]),
        ),
      ),
    );
  }
}
