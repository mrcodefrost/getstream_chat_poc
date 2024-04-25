import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/screens/chat_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../widgets/widgets_all.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late final _userListController = StreamUserListController(
    client: StreamChatCore.of(context).client,
    limit: 20,
    filter: Filter.notEqual('id', StreamChatCore.of(context).currentUser!.id),
  );

  @override
  void initState() {
    _userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    _userListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _userListController.refresh(),
        child: StreamUserListView(
          controller: _userListController,
          emptyBuilder: (context) => const Center(
            child: Text('There are no users'),
          ),
          itemBuilder: (context, users, index, userTile) =>
              ContactTile(user: users[index]),
          loadingBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, e) => DisplayErrorMessage(
            error: e,
          ),
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.user,
  });

  final User user;

  Future<void> createChannel(BuildContext context) async {
    final core = StreamChatCore.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        user.id,
      ]
    });
    await channel.watch();

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) =>
    //         StreamChannel(child: ChatScreen(), channel: channel)));

    // The () => StreamChannel(child: ChatScreen(), channel: channel)
    // part is a callback function that returns the widget you want to navigate to.
    // In this case, it's creating an instance of StreamChannel and
    // passing ChatScreen() and channel as parameters.

    Get.to(() => StreamChannel(channel: channel, child: const ChatScreen()));

    // Get.to(ChatScreen());

    // Navigator.of(context).push(
    //   ChatScreen.routeWithChannel(channel),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        createChannel(context);
      },
      child: ListTile(
        leading: Avatar.small(url: user.image),
        title: Text(user.name),
      ),
    );
  }
}
