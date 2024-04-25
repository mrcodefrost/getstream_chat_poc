import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/controllers/auth_controller.dart';
import 'package:getstream_chat_poc/helpers/auth_gate.dart';
import 'package:getstream_chat_poc/helpers/helpers.dart';
import 'package:getstream_chat_poc/stream_keys.dart';

import '../widgets/widgets_all.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              Hero(
                tag: 'hero-profile-picture',
                child: Avatar.large(
                    url: user?.image ?? Helpers.randomPictureUrl()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user?.name ?? 'No name'),
              ),
              const Divider(),
              const _SignOutButton(),
            ],
          ),
        ),
      );
    });
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });

    try {
      // TODO sign out function here

      await context.signOutCurrentUser;
      Get.offAll(const AuthGate());
    } on Exception catch (e, st) {
      logger.e('Could not sign out', error: e, stackTrace: st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: _signOut,
            child: const Text('Sign out'),
          );
  }
}
