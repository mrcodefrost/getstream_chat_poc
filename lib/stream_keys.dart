import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// Chat POC v2
const apiKey = "bzdrv8eyew7b";

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  // Fetches the current user image
  String? get currentUserImage => StreamChatCore.of(this).currentUser?.image;

  // Fetches the current user
  User? get currentUser => StreamChatCore.of(this).currentUser;

  // TODO check if this is the auth state of current user or

  // Fetches the auth state of current user - Most likely
  Future<void> get signOutCurrentUser =>
      StreamChatCore.of(this).client.disconnectUser();

  // Another method
  // await StreamChatState().client.disconnectUser();
}
