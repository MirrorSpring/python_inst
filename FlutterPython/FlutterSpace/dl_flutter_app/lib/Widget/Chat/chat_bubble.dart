import 'package:dl_flutter_app/View/review/review_page.dart';
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
        ? Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color.fromARGB(255, 199, 199, 199),
                  width: 3.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(chat.chatText),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 215, 212, 252),
                      ),
                    ),
                    onPressed: () {
                      // 리뷰 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '거래 확정',
                      style: TextStyle(
                        color: Color.fromARGB(255, 82, 75, 225),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        // 평범한 채팅이면 이 컨테이너를 보여줌
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
