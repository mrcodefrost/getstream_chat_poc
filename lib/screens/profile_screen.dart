import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/controllers/auth_controller.dart';
import 'package:getstream_chat_poc/helpers/helpers.dart';
import 'package:getstream_chat_poc/helpers/stream_helpers.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../widgets/widgets_all.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    url: context.currentUser?.image ??
                        Helpers.randomPictureUrl()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.currentUser?.name ?? 'No name'),
              ),
              const Divider(),
              SignOutButton(
                onPressed: () async {
                  final client = StreamChatCore.of(context).client;
                  await authController.signOut(client);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SignOutButton extends StatefulWidget {
  const SignOutButton({
    super.key,
    required this.onPressed,
  });

  final Future<void> Function() onPressed;

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  bool _loading = false;

  void _handleSignOut() async {
    setState(() {
      _loading = true; // Set loading to true when sign out starts
    });
    // Perform sign out operation
    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() {
          _loading = false; // Set loading to false when sign out completes
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: _handleSignOut,
            child: const Text('Sign out'),
          );
  }
}
