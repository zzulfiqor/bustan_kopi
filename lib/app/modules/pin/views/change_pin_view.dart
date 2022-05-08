import 'package:bustan_kopi/app/modules/pin/controllers/change_pin_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';


class ChangePinView extends GetView<ChangePinController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Ganti PIN', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Masukkan PIN Baru Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // PIN
          HeightBox(16),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Pinput(
                length: 6,
                obscureText: true,
                onCompleted: (pin) {
                  controller.submitPin(pin);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
