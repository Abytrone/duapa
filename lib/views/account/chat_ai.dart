import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:duapa/services/ai_chat_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatAIScreen extends StatefulWidget {
  const ChatAIScreen({super.key});

  @override
  State<ChatAIScreen> createState() => _ChatAIScreenState();
}

class _ChatAIScreenState extends State<ChatAIScreen> {
  final AiChatServices aiChatServices = AiChatServices();
  final TextEditingController prompt = TextEditingController();

  List<ChatMessage> messages = [];

  final Gemini gemini = Gemini.instance;

  final currentUser = ChatUser(
    id: '1',
    firstName: 'Aby',
    lastName: 'Trone',
  );

  final geminiUser = ChatUser(
    id: "2",
    firstName: "Duapa",
    profileImage: "assets/app_icon/foreground.png",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Chat Assistant'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: DashChat(
          currentUser: currentUser,
          inputOptions: const InputOptions(
            textCapitalization: TextCapitalization.sentences,
            alwaysShowSend: true,
          ),
          messageOptions: MessageOptions(
            // messageTextBuilder: (message, previousMessage, nextMessage) {
            //   return RichText(
            //     text: TextSpan(
            //       text: message.text,
            //       style: const TextStyle(color: Colors.black54),
            //     ),
            //   );
            // },
            onPressMessage: (message) {
              Clipboard.setData(ClipboardData(text: message.text))
                  .then((value) {
                AbySnackBar.successSnackbar(
                    text: 'Message coppied to clipbord');
              }).catchError((e) {
                AbySnackBar.errorSnackbar(text: e);
              });
            },
          ),
          onSend: (message) async {
            setState(() {
              messages.insert(0, message);
            });

            try {
              String question = message.text;
              List<Uint8List>? images;
              if (message.medias?.isNotEmpty ?? false) {
                images = [
                  File(message.medias!.first.url).readAsBytesSync(),
                ];
              }
              gemini
                  .streamGenerateContent(
                question,
                images: images,
              )
                  .listen((event) {
                ChatMessage? lastMessage = messages.firstOrNull;
                if (lastMessage != null && lastMessage.user == geminiUser) {
                  lastMessage = messages.removeAt(0);
                  String response = event.content?.parts?.fold("",
                          (previous, current) => "$previous ${current.text}") ??
                      "";
                  lastMessage.text += response;
                  setState(
                    () {
                      messages = [lastMessage!, ...messages];
                    },
                  );
                } else {
                  String response = event.content?.parts?.fold("",
                          (previous, current) => "$previous ${current.text}") ??
                      "";
                  ChatMessage message = ChatMessage(
                    user: geminiUser,
                    createdAt: DateTime.now(),
                    text: response,
                  );
                  setState(() {
                    messages = [message, ...messages];
                  });
                }
              });
            } catch (e) {
              print(e);
            }

            // List<OpenAIChatCompletionChoiceMessageModel> messageHistory =
            //     messages.reversed.map((m) {
            //   if (m.user == currentUser) {
            //     return OpenAIChatCompletionChoiceMessageModel(
            //       role: OpenAIChatMessageRole.user,
            //       content: [
            //         OpenAIChatCompletionChoiceMessageContentItemModel.text(
            //             m.text),
            //       ],
            //     );
            //   } else {
            //     return OpenAIChatCompletionChoiceMessageModel(
            //       role: OpenAIChatMessageRole.system,
            //       content: [
            //         OpenAIChatCompletionChoiceMessageContentItemModel.text(
            //             m.text),
            //       ],
            //     );
            //   }
            // }).toList();

            // final openAi = await OpenAI.instance.chat.create(
            //   model: 'davinci-codex',
            //   messages: messageHistory,
            // );

            // print(openAi.choices);

            // for (var element in openAi.choices) {
            //   setState(() {
            //     messages.insert(
            //       0,
            //       ChatMessage(
            //         user: ChatUser(id: '2'),
            //         createdAt: DateTime.now(),
            //         text: element.message.content![0].text!,
            //       ),
            //     );
            //   });
            // }
          },
          messages: messages,
        ),
        // child: ListView.builder(
        //   itemCount: 1,
        //   itemBuilder: (context, index) {
        //     return UserChatItem();
        //   },
        // ),
      ),
      // bottomNavigationBar: SafeArea(
      //   left: true,
      //   right: true,
      //   bottom: true,
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //     ),
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 15),
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(10),
      //               boxShadow: [cardShadow()],
      //             ),
      //             child: TextFormField(
      //               controller: prompt,
      //               decoration: const InputDecoration(
      //                 border: InputBorder.none,
      //                 hintText: 'Type here!',
      //               ),
      //             ),
      //           ),
      //         ),
      //         IconButton(
      //           onPressed: () {
      //             aiChatServices.sendChat(text: prompt.text);
      //           },
      //           style: ButtonStyle(
      //             backgroundColor:
      //                 const MaterialStatePropertyAll(kPrimaryColor),
      //             minimumSize: const MaterialStatePropertyAll(Size(50, 50)),
      //             shape: MaterialStatePropertyAll(
      //               RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //             ),
      //           ),
      //           icon: aiChatServices.loading.isFalse
      //               ? const Icon(
      //                   Iconsax.send1,
      //                   color: Colors.white,
      //                 )
      //               : const CircularProgressIndicator(
      //                   strokeWidth: 2,
      //                 ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
