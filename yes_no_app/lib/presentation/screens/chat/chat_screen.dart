import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://addons-media.operacdn.com/media/CACHE/images/themes/45/131845/1.0-rev1/images/7cf6db01-a5f7-4107-acf0-47651d14ab03/50d5f7da54bfb2b13ac648ce67416ad4.jpg'),
          ),
        ),
        title: const Text('Scarlett Johansson'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messagesList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messagesList[index];
                return (message.fromWho == FromWho.hers)
                    ?  HerMessageBubble(message: message)
                    :  MyMessageBubble(message:message);
              },
            )),
             MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}
