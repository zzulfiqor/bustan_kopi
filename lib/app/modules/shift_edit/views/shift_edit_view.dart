import 'package:bustan_kopi/app/data/models/shift_model.dart';
import 'package:bustan_kopi/app/modules/shift_edit/views/widgets/shift_edit_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../controllers/shift_edit_controller.dart';

class ShiftEditView extends GetView<ShiftEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Waktu Shift'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ShiftModel>('shift').listenable(),
        builder: (_, Box<ShiftModel> box, __) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(box.values.toList()[index].name ?? ''),
                subtitle: Text('Pukul : ' +
                    box.values.toList()[index].timeStart.toString() +
                    ' - ' +
                    box.values.toList()[index].timeEnd.toString()),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Get.bottomSheet(Container(
                    child: ShiftEditDialog(
                      shift: box.values.toList()[index],
                    ),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
