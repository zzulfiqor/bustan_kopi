import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absen_input_controller.dart';

class AbsenInputView extends GetView<AbsenInputController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AbsenInputView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AbsenInputView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
