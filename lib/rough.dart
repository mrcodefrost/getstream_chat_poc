// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const StreamChannelHeader(),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: StreamMessageListView(
//                 markReadWhenAtTheBottom: true,
//                 messageBuilder: (context, details, messageList, defaultImpl) {
//                   return defaultImpl.copyWith(attachmentActionsModalBuilder:
//                       (buildContext, attachment, attachmentActionsModal) {
//                     return attachmentActionsModal.copyWith();
//                   });
//                 },
//               ),
//             ),
//             StreamMessageInput(),
//           ],
//         ),
//       ),
//     );
//   }
// }
