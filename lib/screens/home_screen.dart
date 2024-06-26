import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getstream_chat_poc/helpers/stream_helpers.dart';
import 'package:getstream_chat_poc/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/avatar.dart';
import 'screens_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = const [
    MessagesScreen(),
    StreamContactsScreen(),
    PhoneBookScreen(),
  ];

  int _pageNumber = 0; // original condition

  void onPageChange(int newPageNumber) {
    setState(() {
      _pageNumber = newPageNumber; // new condition updated
    });
  }

  Future<void> requestContactsPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestContactsPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat POC'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'hero-profile-picture',
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
              ),
            ),
          ),
        ],
      ),
      body: pages[_pageNumber],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onPageChange,
        currentIndex: _pageNumber,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.stream), label: 'Stream contacts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: 'Phone book')
        ],
      ),
    );
  }
}
