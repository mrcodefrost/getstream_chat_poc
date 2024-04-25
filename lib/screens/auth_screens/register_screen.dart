import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/controllers/auth_controller.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../helpers/validations.dart';
import '../screens_all.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.onTap});

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
                'Register new user',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: authController.registerNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.face),
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                inputFormatters: [
                  Validations.emptyValidator(),
                ],
              ),
              const SizedBox(height: 20),
              // User Mobile Number
              TextFormField(
                controller: authController.registerNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: 'Mobile Number',
                  hintText: 'Mobile Number',
                ),
                inputFormatters: [
                  Validations.trimSpaces(),
                  Validations.onlyNumbers(),
                  Validations.emptyValidator(),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final client = StreamChatCore.of(context).client;
                    await authController.registerUser(client);
                    Get.offAll(const HomeScreen());
                  },
                  child: const Text('Register')),
              TextButton(
                  onPressed: () {
                    Get.to(LoginScreen(onTap: onTap));
                  },
                  child: const Text('Already have an account ? Login')),
            ],
          ),
        ),
      );
    });
  }
}
