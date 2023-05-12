import 'package:flutter/material.dart';

import '../../../shared/text_field.widget.dart';
import '../../../shared/view_controller.interface.dart';
import '../../domain/abstractions/login_controller.interface.dart';

class LoginScreen extends ViewController<ILoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: const Text(
                'LOGO',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Login Form
            TextFieldWidget(
              label: 'Username',
              field: controller.loginField,
            ),
            const SizedBox(height: 20.0),
            TextFieldWidget(
              label: 'Password',
              field: controller.passwordField,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.doLogin,
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Register?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}