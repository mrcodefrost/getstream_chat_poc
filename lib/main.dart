import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/controllers/auth_controller.dart';
import 'package:getstream_chat_poc/helpers/auth_gate.dart';
import 'package:getstream_chat_poc/stream_keys.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(apiKey, logLevel: Level.INFO);
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
        streamChatThemeData: StreamChatThemeData(),
        client: client,
        child: child ??
            const Center(
              child: Text('Null'),
            ),
      ),
      home: AuthGate(),
    );
  }
}
