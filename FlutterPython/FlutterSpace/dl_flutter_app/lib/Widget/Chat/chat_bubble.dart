// import 'package:dl_flutter_app/View/review/review_page.dart';
import 'package:dl_flutter_app/Widget/Chat/confirm_chat_bubble.dart';
import 'package:dl_flutter_app/Widget/Chat/review_chat_bubble.dart';
import 'package:flutter/material.dart';

import '../../Model/Chat/chat.dart';
import '../../Model/User/static_user.dart';

class ChatBubble extends StatelessWidget {
  final Chat chat;

  const ChatBubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return chat.chatText.contains("님이 거래 확정을 요청했습니다.")
        // 거래 확정 요청이면 이 컨테이너를 보여줌
        ? ConfirmChatBubble(
            chat: chat,
            kindOfChat: '거래 확정',
          )
        : chat.chatText.contains("님이 거래를 확정했습니다.")
            ? ReviewChatBubble(chat: chat, kindOfChat: '리뷰 쓰러 가기')
            : Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(chat.chatText),
                    ],
                  ),
                ),
              );
  }
}
