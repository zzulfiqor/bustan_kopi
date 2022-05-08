import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Login Field
            SizedBox(height: 20),
            VStack(
              [
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  height: 130,
                ),

                // Email
                HeightBox(24),
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.email = value;
                  },
                ),

                // Password
                SizedBox(height: 20),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.password = value;
                  },
                ),

                // Login Button
                SizedBox(height: 24),
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        (controller.email == '' || controller.password == '')
                            ? null
                            : () => controller.loginProcess(),
                    child: "Login".text.makeCentered(),
                  ).h(50),
                )
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).pSymmetric(h: 12, v: 16).marginSymmetric(horizontal: 12),

            // Trademark
            "Bustan Kopi | 2022"
                .text
                .gray400
                .makeCentered()
                .marginOnly(bottom: 16),
          ],
        ),
      ),
    );
  }
}
