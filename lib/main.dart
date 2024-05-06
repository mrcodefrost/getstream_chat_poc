import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/helpers/auth_gate.dart';
import 'package:getstream_chat_poc/helpers/stream_helpers.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final chatPersistentClient = StreamChatPersistenceClient(
    logLevel: Level.INFO,
    connectionMode: ConnectionMode.background,
  );

  // remove this to fix sort for now
  final client = StreamChatClient(apiKey, logLevel: Level.INFO)
    ..chatPersistenceClient = chatPersistentClient;
  Get.put(AuthController());
  // final channel = client.channel('messaging');
  // await client.connectUser(User(id: 'broker-mindit'), userToken);
  // await channel.watch();

  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stream Chat POC',
      builder: (context, child) => StreamChat(
          streamChatThemeData: StreamChatThemeData(
              ownMessageTheme: StreamMessageThemeData(
                messageBackgroundColor: Colors.red,
                messageTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              otherMessageTheme: StreamMessageThemeData(
                messageBackgroundColor: Colors.blue,
                messageTextStyle: TextStyle(
                  color: Colors.white,
                ),
              )),
          client: client,
          child: child!),
      home: const AuthGate(),
    );
  }
}
