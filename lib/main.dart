import 'package:flutter/material.dart';
import 'package:getstream_chat_poc/stream_keys.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = StreamChatClient(apiKey, logLevel: Level.INFO);

  // final channel = client.channel('messaging');
  //
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await client.connectUser(User(id: 'broker-mindit'), userToken);
  // await channel.watch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(child: Text('Test')),
      ),
    );
  }
}
