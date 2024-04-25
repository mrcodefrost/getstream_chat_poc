import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/helpers/auth_gate.dart';
import 'package:getstream_chat_poc/helpers/helpers.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AuthController extends GetxController {
  // text controllers
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerNumberController = TextEditingController();
  TextEditingController loginNumberController = TextEditingController();

  void clearRegisterControllers() {
    registerNumberController.clear();
    registerNameController.clear();
  }

  // USER ADDITION

  Future<void> registerUser(StreamChatClient client) async {
    try {
      // create user function
      // final client = StreamChatState().client;
      // final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(id: registerNumberController.text, extraData: {
          'name': registerNameController.text,
          'image': Helpers.randomPictureUrl()
        }),
        client.devToken(registerNumberController.text).rawValue,
      );

      Get.snackbar('Success', 'User added successfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Unable to create user', colorText: Colors.red);
      debugPrint(e.toString());
    } finally {
      clearRegisterControllers();
      update();
    }
  }

  Future<void> loginUser(StreamChatClient client) async {
    try {
      // create user function
      // final client = StreamChatState().client;
      // final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(id: loginNumberController.text),
        client.devToken(loginNumberController.text).rawValue,
      );

      Get.snackbar('Success', 'Logged in successfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Unable to login user', colorText: Colors.red);
      debugPrint(e.toString());
    } finally {
      loginNumberController.clear();
      update();
    }
  }

  // USER LOGOUT

  Future<void> signOut(StreamChatClient client) async {
    try {
      await client.disconnectUser();
      Get.offAll(const AuthGate());
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      update();
    }
  }
}
