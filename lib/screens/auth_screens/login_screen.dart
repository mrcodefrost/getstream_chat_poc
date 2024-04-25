import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../screens_all.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: authController.loginNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final client = StreamChatCore.of(context).client;
                    await authController.loginUser(client);
                    Get.offAll(const HomeScreen());
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Get.to(RegisterScreen(
                      onTap: onTap,
                    ));
                  },
                  child: const Text('Register new account')),
            ],
          ),
        ),
      );
    });
  }
}
