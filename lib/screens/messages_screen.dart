import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'screens_all.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late final _channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
  );

  // Not sure if doInitialLoad is required but just to be sure
  @override
  void initState() {
    super.initState();
    _channelListController.doInitialLoad();
  }

  @override
  void dispose() {
    _channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _channelListController.refresh,
        child: StreamChannelListView(
          controller: _channelListController,
          onChannelTap: (channel) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StreamChannel(
                channel: channel,
                child: const ChatScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
