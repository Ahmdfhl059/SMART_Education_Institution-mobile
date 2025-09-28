// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
//
// import '../../../widgets/widgets.dart';
//
// const String GEMINI_API_KEY = "AIzaSyD_QK2nSl4v2zB9IJ16dtApqS1G_oE2zHU";
//
// // AIzaSyCGAKeVtGYL4DKK60hbSsHlo96kxQKM5GI
// class GeminiView extends StatefulWidget {
//   const GeminiView({super.key});
//
//   @override
//   State<GeminiView> createState() => _GeminiViewState();
// }
//
// class _GeminiViewState extends State<GeminiView> {
//   final Gemini gemini = Gemini.instance;
//   List<ChatMessage> messages = [];
//   ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
//   ChatUser geminiUser = ChatUser(
//     id: '1',
//     firstName: 'Gemini',
//     // profileImage:
//     //     'https://images.seeklogo.com/logo-png/61/2/gemini-icon-logo-png_seeklogo-611605.png',
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(context, 'Gemini chat', false),
//       body: buildUI(),
//     );
//   }
//
//   // Widget buildUI() {
//   //   return DashChat(
//   //     currentUser: currentUser,
//   //     onSend: sendMessage,
//   //     messages: messages,
//   //   );
//   // }
//   Widget buildUI() {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return DashChat(
//       currentUser: currentUser,
//       onSend: sendMessage,
//       messages: messages,
//
//       // Bubble styling (user and Gemini)
//       messageOptions: MessageOptions(
//         currentUserTextColor: isDark ? Colors.white : Colors.black,
//         containerColor:
//         isDark ? Color(0xFF00B9AD) : Color(0xFF00B9AD), // User bubble color
//         textColor: isDark ? Colors.white : Colors.black, // Gemini bubble text
//         avatarBuilder: (user, onTap, size) {
//           if (user.id == '1') {
//             return Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: CircleAvatar(
//                 backgroundColor: Theme.of(context).colorScheme.secondary,
//                 child: Text('G'),
//               ),
//             );
//           } else {
//             return const SizedBox.shrink(); // returns an empty widget instead of null
//           }
//         },
//       ),
//
//       // Input field styling
//       inputOptions: InputOptions(
//         inputTextStyle: TextStyle(color: theme.textTheme.bodyLarge?.color),
//         inputDecoration: InputDecoration(
//           filled: true,
//           fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
//           hintText: "Type your message...",
//           hintStyle: TextStyle(
//             color: isDark ? Colors.grey[400] : Colors.grey[700],
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 12,
//           ),
//         ),
//         sendButtonBuilder:
//             (onSend) => IconButton(
//           icon: Icon(Icons.send, color: theme.colorScheme.primary),
//           onPressed: onSend,
//         ),
//       ),
//     );
//   }
//
//   void sendMessage(ChatMessage chatMessage) {
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//
//     try {
//       String question = chatMessage.text;
//
//       // Create an initial empty Gemini message
//       ChatMessage streamingMessage = ChatMessage(
//         user: geminiUser,
//         createdAt: DateTime.now(),
//         text: '',
//       );
//
//       // Add that Gemini message on top
//       setState(() {
//         messages = [streamingMessage, ...messages];
//       });
//
//       // Stream response and append to existing Gemini message
//       gemini.promptStream(parts: [Part.text(question)]).listen((event) {
//         final newText =
//             event?.content?.parts?.map((e) => (e as TextPart).text).join() ??
//                 "";
//
//         if (newText.isNotEmpty) {
//           // Update the text of the first Gemini message
//           streamingMessage.text += newText;
//
//           setState(() {
//             messages[0] = streamingMessage;
//           });
//         }
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
// //   void sendMessage2(ChatMessage chatMessage) {
// //   setState(() {
// //     messages = [chatMessage, ...messages];
// //   });
//
// //   try {
// //     String question = chatMessage.text;
// //     gemini.promptStream(
// //       parts: [Part.text(question)],
// //     ).listen((event) {
// //       String response = event?.content?.parts?.fold(
// //             "",
// //             (previous, current) => "$previous ${current.toString()}",
// //           ) ??
// //           "";
//
// //       ChatMessage? lastMessage = messages.firstOrNull;
// //       if (lastMessage != null && lastMessage.user == geminiUser) {
// //         lastMessage = messages.removeAt(0);
// //         lastMessage.text += response;
// //         setState(() {
// //           messages = [lastMessage!, ...messages];
// //         });
// //       } else {
// //         ChatMessage message = ChatMessage(
// //           user: geminiUser,
// //           createdAt: DateTime.now(),
// //           text: response,
// //         );
// //         setState(() {
// //           messages = [message, ...messages];
// //         });
// //       }
// //     });
// //   } catch (e) {
// //     print("Error: $e");
// //   }
// // }
//
// // void sendMessage(ChatMessage chatMessage) {
// //   setState(() {
// //     messages = [chatMessage, ...messages];
// //   });
// //   try {
// //     String question = chatMessage.text;
// //     // gemini.promptStream(parts: messages);
// //     gemini.streamGenerateContent(question).listen((event) {
// //       ChatMessage? lastMessage = messages.firstOrNull;
// //       if (lastMessage != null && lastMessage.user == geminiUser) {
// //         lastMessage = messages.removeAt(0);
// //         String response =
// //             event.content?.parts?.fold(
// //               "",
// //               (previous, current) => "$previous ${current.toString()}",
// //             ) ??
// //             "";
// //         lastMessage.text += response;
// //         setState(() {
// //           messages = [lastMessage!, ...messages];
// //         });
// //       } else {
// //         String response =
// //             event.content?.parts?.fold(
// //               "",
// //               (previous, current) => "$previous ${current.toString()}",
// //             ) ??
// //             "";
// //         ChatMessage message = ChatMessage(
// //           user: geminiUser,
// //           createdAt: DateTime.now(),
// //           text: response,
// //         );
// //         setState(() {
// //           messages = [message, ...messages];
// //         });
// //       }
// //     });
// //   } catch (e) {
// //     print(e);
// //   }
// // }
// //
// }
//
//
// // void sendMessage(ChatMessage chatMessage) {
// //   setState(() {
// //     messages = [chatMessage, ...messages];
// //   });
//
// //   try {
// //     String question = chatMessage.text;
// //     gemini.streamGenerateContent(question).listen((event) {
// //       print("Gemini API Response toString: ${event.content.toString()}");
//
// //       ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;
//
// //       if (lastMessage != null && lastMessage.user == geminiUser) {
// //         lastMessage = messages.removeAt(0);
//
// //         // Update this part based on the actual structure of event.content
// //         String response = event.content?.toString() ?? ''; // Temporarily print content as string
// //         lastMessage.text += response;
//
// //         setState(() {
// //           messages = [lastMessage!, ...messages];
// //         });
// //       } else {
// //         String response = event.content?.toString() ?? ''; // Temporarily print content as string
//
// //         ChatMessage message = ChatMessage(
// //           user: geminiUser,
// //           createdAt: DateTime.now(),
// //           text: response,
// //         );
//
// //         setState(() {
// //           messages = [message, ...messages];
// //         });
// //       }
// //     });
// //   } catch (e) {
// //     print(e);
// //   }
// // }
