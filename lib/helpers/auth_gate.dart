import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../screens/screens_all.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // stream: StreamChatState().currentUserStream : why? =  read the EOF
        stream: StreamChat.of(context).client.state.currentUserStream,
        builder: (context, snapshot) {
          // user is logged in

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // user is NOT logged in

          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show the login page

  bool showLogInPage = true;

  // toggle between login and register page

  void togglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return RegisterScreen(onTap: togglePages);
    }
  }
}

/*
* The difference lies in how you're accessing the StreamChatState instance.

    StreamChat.of(context).client.state.currentUserStream:
        In this approach, you're using the StreamChat.of(context) method to obtain the current StreamChatState instance from the widget tree.
        Then, you're accessing the client property of StreamChatState, which is the StreamChatClient instance.
        From the StreamChatClient, you're accessing the state property, which is the ChatClientState instance.
        Finally, from the ChatClientState, you're accessing the currentUserStream property, which is a stream representing the current user.

    StreamChatState().currentUserStream:
        In this approach, you're directly invoking the currentUserStream property of the StreamChatState class itself.
        This approach assumes that you have direct access to an instance of StreamChatState, which may not always be the case, especially if you're not using it within the context of a widget.

The first approach is more common and recommended when you need to access the StreamChatState instance from within a widget. It allows you to access the current user stream by traversing the widget tree hierarchy and obtaining the necessary state from the StreamChat widget.

The second approach would be suitable if you had direct access to an instance of StreamChatState outside of a widget context, which is less common in typical Flutter applications.

In summary, the first approach is more flexible and suitable for accessing the chat state within widgets, while the second approach is more limited and may not always be applicable in widget contexts.
*
* */
