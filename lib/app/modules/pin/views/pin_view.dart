import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/pin_controller.dart';

class PinView extends GetView<PinController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Input PIN', style: TextStyle(color: Colors.black)),
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
                'Masukkan PIN Anda',
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
