import 'package:flutter/material.dart';

import '../../Model/Chat/chat.dart';
import '../../Model/static_user.dart';

class ChatBubble extends StatelessWidget {
  final Chat chat;

  const ChatBubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: chat.sendUserId == StaticUser.userId
          ? const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 220, 220, 220),
            )
          : const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 174, 195, 250),
            ),
      // width: 250,
      constraints: const BoxConstraints(maxWidth: 250, minWidth: 50),
      child: ListTile(
        title: Text(chat.chatText),
      ),
    );
  }
}
