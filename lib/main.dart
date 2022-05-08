import 'package:bustan_kopi/app/data/models/kehadiran_model.dart';
import 'package:bustan_kopi/app/data/models/status_kehadiran_enum.dart';
import 'package:bustan_kopi/app/data/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(KehadiranAdapter());
  Hive.registerAdapter(StatusKehadiranAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // open hive
  await Hive.openBox<UserModel>('user');
  await Hive.openBox<Kehadiran>('kehadiran');
  await Hive.openBox<int>('nominalGaji');
  await Hive.openBox<UserModel>('activeUser');
  await Hive.openBox<String>('pin');

  

  runApp(
    GetMaterialApp(
        title: "Bustan Kopi",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        locale: Locale('id', 'ID'),
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        )),
  );
}
