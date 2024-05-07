import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneBookScreen extends StatelessWidget {
  const PhoneBookScreen({super.key});

  Future<List<Contact>> fetchPhonebook() async {
    final List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: fetchPhonebook(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Contact> contacts = snapshot.data!;
          // Display contacts in the UI
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];
              return ListTile(
                title: Text(contact.displayName ?? ''),
                subtitle: Text(contact.phones?.first.value ?? ''),
              );
            },
          );
        }
      },
    );
  }
}
