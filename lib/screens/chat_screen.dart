import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          const Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(
            validator: (message) {
              // returning false disables the button
              if (message.text?.isNotEmpty == true ||
                  message.attachments.isNotEmpty) {
                // If the message contains more than 8 consecutive digits, return false
                if (message.text?.contains(RegExp(r'\d{7,}')) == true) {
                  return false;
                } else {
                  // Otherwise, return true to indicate that the message is valid
                  return true;
                }
              } else {
                // If the message is empty and has no attachments, return false
                return false;
              }
            },
          ),
        ],
      ),
    );
  }
}
