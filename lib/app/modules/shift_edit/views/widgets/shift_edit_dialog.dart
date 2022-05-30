import 'package:bustan_kopi/app/data/models/shift_model.dart';
import 'package:bustan_kopi/app/modules/shift_edit/controllers/shift_edit_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShiftEditDialog extends GetView<ShiftEditDialogController> {
  final ShiftModel? shift;
  const ShiftEditDialog({Key? key, required this.shift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Start Time
    var startTimeHour = int.parse(shift?.timeStart?.split(':').first ?? '0');
    var startTimeMinute = int.parse(shift?.timeStart?.split(':').last ?? '0');

    // endt Time
    var endTimeHour = int.parse(shift?.timeEnd?.split(':').first ?? '0');
    var endTimeMinute = int.parse(shift?.timeEnd?.split(':').last ?? '0');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          children: [
            // Shift Name
            Text('Shift ${shift?.id}').text.size(18).bold.makeCentered(),

            // Row of Start - End Time
            HeightBox(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Start Time
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Jam Mulai',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    HeightBox(8),
                    GestureDetector(
                      onTap: () {
                        showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: startTimeHour,
                                    minute: startTimeMinute))
                            .then((value) {
                          if (value != null) {
                            controller.selectedStartHour = value.hour;
                            controller.selectedStartMinute = value.minute;
                          } else {
                            controller.selectedStartHour = startTimeHour;
                            controller.selectedStartMinute = startTimeMinute;
                          }
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: controller.selectedStartHour == 0
                            ? Text(
                                '${startTimeHour.toString().padLeft(2, '0')}:${startTimeMinute.toString().padLeft(2, '0')}',
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                '${controller.selectedStartHour.toString().padLeft(2, '0')}:${controller.selectedStartMinute.toString().padLeft(2, '0')}',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),

                // Divider
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey,
                ),

                // End Time
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Jam Selesai',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    HeightBox(8),
                    GestureDetector(
                      onTap: () {
                        showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: endTimeHour, minute: endTimeMinute))
                            .then((value) {
                          if (value != null) {
                            controller.selectedEndHour = value.hour;
                            controller.selectedEndMinute = value.minute;
                          } else {
                            controller.selectedEndHour = endTimeHour;
                            controller.selectedEndMinute = endTimeMinute;
                          }
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: controller.selectedEndHour == 0
                            ? Text(
                                '${endTimeHour.toString().padLeft(2, '0')}:${endTimeMinute.toString().padLeft(2, '0')}',
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                '${controller.selectedEndHour.toString().padLeft(2, '0')}:${controller.selectedEndMinute.toString().padLeft(2, '0')}',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Confirm Button
            HeightBox(32),
            SizedBox(
              width: Get.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedEndHour == 0 ||
                          controller.selectedEndHour == 0
                      ? Get.rawSnackbar(
                          title: 'Peringatan',
                          message: 'Set Jam Mulai dan Jam Selesai')
                      : controller.setShiftTime(shift!);
                },
                child: Text('Ubah'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
