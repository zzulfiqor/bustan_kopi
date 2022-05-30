import 'package:bustan_kopi/app/data/models/shift_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class ShiftEditDialogController extends GetxController {
  // Selected Start hour
  final _selectedStartHour = 0.obs;
  int get selectedStartHour => _selectedStartHour.value;
  set selectedStartHour(int value) => _selectedStartHour.value = value;

  // Selected End hour
  final _selectedEndHour = 0.obs;
  int get selectedEndHour => _selectedEndHour.value;
  set selectedEndHour(int value) => _selectedEndHour.value = value;

  // selected Start Minute
  final _selectedStartMinute = 0.obs;
  int get selectedStartMinute => _selectedStartMinute.value;
  set selectedStartMinute(int value) => _selectedStartMinute.value = value;

  // selected End Minute
  final _selectedEndMinute = 0.obs;
  int get selectedEndMinute => _selectedEndMinute.value;
  set selectedEndMinute(int value) => _selectedEndMinute.value = value;

  setShiftTime(ShiftModel shift) {
    var box = Hive.box<ShiftModel>('shift');
    ShiftModel newData = ShiftModel(
      id: shift.id,
      name: shift.name,
      timeStart:
          "${selectedStartHour < 10 ? '0' + selectedStartHour.toString() : selectedStartHour}:${selectedStartMinute < 10 ? '0' + selectedStartMinute.toString() : selectedStartMinute}",
      timeEnd:
          "${selectedEndHour < 10 ? '0' + selectedEndHour.toString() : selectedEndHour}:${selectedEndMinute < 10 ? '0' + selectedEndMinute.toString() : selectedEndMinute}",
    );
    var mapBox = box.toMap();
    int key = 0;

    mapBox.forEach((key1, value) {
      print(key1.toString() + shift.id.toString());
      if (key1 + 1 == int.parse(shift.id!)) {
        key = key1;
        print(key.toString() + "hehe");
      }
    });

    box.put(key, newData);

    Get.back();
  }
}
