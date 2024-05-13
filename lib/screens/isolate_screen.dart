// import 'dart:async';
// import 'dart:convert';
// import 'dart:isolate';
//
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/services.dart';
// import 'package:geniex/utils/preference_manager.dart';
// import 'package:geniex/utils/utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../network/api_endpoints.dart';
// import '../models/save_contacts_service_model.dart';
//

//----------------------------------------------------//
// WORKING ISOLATE //
//----------------------------------------------------//

// class SaveContactsService {
// // Save the contacts
//   static Future<void> _savePhoneContactsAPI(List<dynamic> args) async {
//     BackgroundIsolateBinaryMessenger.ensureInitialized(args[3]);
//     SendPort resultPort = args[0];
//
//     // Function to convert list of Contact objects to list of Contacts objects.
//     List<Contacts> convertToContactsList(List<Contact> contacts) {
//       return contacts.map((contact) {
//         return Contacts(
//           name: contact.displayName ?? '',
//           phoneNumber: contact.phones?.first.value ?? '',
//         );
//       }).toList();
//     }
//
//     // Convert list of Contact objects to list of Contacts objects
//     List<Contacts> contactsList = convertToContactsList(args[2]);
//
//     PhoneContactsModel phoneContacts =
//     PhoneContactsModel(userId: args[1], contacts: contactsList);
//
//     // Convert PhoneContactsModel to JSON Map
//     Map<String, dynamic> body = phoneContacts.toJson();
//
//     logger.e('Inside save phone', error: 'Before executing api');
//
//     try {
//       http.Response response = await http.post(
//           Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.savePhoneContacts),
//           body: jsonEncode(body),
//           // headers: HttpClient.getHeaders(),
//           // this gives 403
//           // headers: {
//           //   "Authorization":
//           //   "Bearer ${PreferenceManager.getString(PreferenceManager.token)}",
//           //   "Accept": "application/json",
//           //   "Content-type": "application/json"
//           // }
//           // this gives 400
//           headers: {
//             "Authorization": "Bearer ${args[4]}",
//             "Accept": "application/json",
//             "Content-type": "application/json"
//           }).timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           throw TimeoutException('Can\'t connect in 30 seconds.');
//         },
//       );
//       logger.t('Bearer Token Value',
//           error: PreferenceManager.getString(PreferenceManager.token));
//       logger.t('Bearer Token Value', error: args[4]);
//
//       // Check if the request was successful (status code 200 or 201)
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Request successful, handle response data
//         logger.i('POST request successful:');
//         logger.i('Response body: ${response.body}');
//       } else {
//         // Request failed, handle error
//         logger.e(
//             'Failed to make POST request. Status code: ${response.statusCode}',
//             error: response.body);
//       }
//     } catch (e) {
//       logger.e('Exception occurred while making POST request: $e');
//     }
//
//     // CommonApiService().savePhoneContacts(body).then((value) {
//     //   if (value.statusCode == 200) {
//     //     logger
//     //         .i('Phone contacts saved in db successfully, user ID: ${args[1]}');
//     //     // PreferenceManager.setData(PreferenceManager.contactsInDb, true);
//     //     Isolate.exit(resultPort, 'Contacts sync completed');
//     //   } else {
//     //     logger.e('Phone contacts  not saved in db, user ID: ${args[1]}',
//     //         error: value.statusCode);
//     //     // PreferenceManager.setData(PreferenceManager.contactsInDb, false);
//     //     var errorResp = CommonErrorRespModel.fromJson(json.decode(value.body));
//     //     logger.e(errorResp.errorMessage, error: value.statusCode);
//     //     Isolate.exit(resultPort, 'Contacts sync not completed');
//     //   }
//     // });
//
//     Isolate.exit(resultPort, 'Contacts sync completed');
//   }
//
// // Run saving contacts in background, this is an isolate function, do not change args
//   static void inBackgroundSaveContacts(String userId) async {
//     String? permissionStatus =
//     PreferenceManager.getString(PreferenceManager.syncContacts);
//     String? contactsInDbStatus =
//     PreferenceManager.getString(PreferenceManager.contactsInDb);
//     String? bearerToken = PreferenceManager.getString(PreferenceManager.token);
//     logger.w('Permission status', error: permissionStatus);
//     logger.w('Contacts in DB status', error: contactsInDbStatus);
//
//     if (permissionStatus == 'true' && contactsInDbStatus != 'true') {
//       final ReceivePort receivePort = ReceivePort();
//       try {
//         final List<Contact> contacts =
//         await ContactsService.getContacts(withThumbnails: false);
//         var rootToken = RootIsolateToken.instance!;
//         await Isolate.spawn(SaveContactsService._savePhoneContactsAPI, [
//           receivePort.sendPort,
//           userId,
//           contacts,
//           rootToken,
//           bearerToken,
//         ]);
//       } catch (e) {
//         logger.e('Isolate Failed', error: e);
//         receivePort.close();
//       } finally {
//         final response = await receivePort.first;
//         logger.i('Response from Isolate function', error: response);
//       }
//     } else if (permissionStatus == null) {
//       logger.e('Permission to access contacts denied : permission status null');
//     } else {
//       logger.e('Permission to access contacts denied');
//     }
//   }
//
// // Permission Handling for Contacts
//   Future<void> requestContactsPermission() async {
//     final status = await Permission.contacts.status;
//     if (status.isDenied) {
//       PreferenceManager.setData(PreferenceManager.syncContacts, false);
//       await Permission.contacts.request().then((value) async {
//         bool newStatus = await Permission.contacts.status.isGranted;
//         if (newStatus) {
//           PreferenceManager.setData(PreferenceManager.syncContacts, true);
//         }
//       });
//     } else if (status.isPermanentlyDenied) {
//       PreferenceManager.setData(PreferenceManager.syncContacts, false);
//       openAppSettings();
//     } else if (status.isGranted) {
//       PreferenceManager.setData(PreferenceManager.syncContacts, true);
//     }
//   }
// }
// //
// // // // Must be top level function
// // Future<dynamic> computeIsolate(Future Function() function) async {
// //   final receivePort = ReceivePort();
// //   var rootToken = RootIsolateToken.instance!;
// //   await Isolate.spawn<_IsolateData>(
// //     _isolateEntry,
// //     _IsolateData(
// //       token: rootToken,
// //       function: function,
// //       answerPort: receivePort.sendPort,
// //     ),
// //   );
// //   // return await receivePort.first;
// // }
// //
// // void _isolateEntry(_IsolateData isolateData) async {
// //   BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
// //   final answer = await isolateData.function();
// //   isolateData.answerPort.send(answer);
// // }
// //
// // class _IsolateData {
// //   final RootIsolateToken token;
// //   final Function function;
// //   final SendPort answerPort;
// //
// //   _IsolateData({
// //     required this.token,
// //     required this.function,
// //     required this.answerPort,
// //   });
// // }
