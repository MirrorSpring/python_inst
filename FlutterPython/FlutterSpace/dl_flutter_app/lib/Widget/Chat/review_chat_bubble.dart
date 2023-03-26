import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dl_flutter_app/Model/Chat/chat.dart';
import 'package:dl_flutter_app/Model/Chat/static_chat.dart';
import 'package:flutter/material.dart';

import '../../Model/User/static_user.dart';
import '../../View/review/review_page.dart';

class ReviewChatBubble extends StatefulWidget {
  final Chat chat;
  final String kindOfChat;

  const ReviewChatBubble(
      {super.key, required this.chat, required this.kindOfChat});

  @override
  State<ReviewChatBubble> createState() => _ReviewChatBubbleState();
}

class _ReviewChatBubbleState extends State<ReviewChatBubble> {
  late bool reviewState;

  @override
  void initState() {
    super.initState();
    reviewState = StaticChat.reviewState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(widget.chat.chatText),
            const SizedBox(height: 10),
            reviewState
                ? const Icon(Icons.check)
                : ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 215, 212, 252),
                      ),
                    ),
                    onPressed: () {
                      // 거래 확정 클릭하면 거래를 확정했습니다 채팅 + 보내기
                      // widget.kindOfChat == "거래 확정"
                      // ? confirmChat().then((value) => updateChatAction())
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewPage(),
                        ),
                      );
                      // reviewState =
                      setState(() {});
                    },
                    child: Text(
                      widget.kindOfChat,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 82, 75, 225),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
// }

  // 거래 확정 채팅 보내기
  Future confirmChat() async {
    print('2. 거래 확정 확인 채팅 보내기');
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(StaticChat.chatRoomId)
        .collection('chat')
        .add({
      'sendUserId': StaticUser.userId,
      'chatTime': DateTime.now(),
      'chatText': "${StaticUser.userName}님이 거래를 확정했습니다.",
      'photoUrl': "",
    });

    // confirmState = true;
  }

  // 채팅방 목록에 가장 최근 채팅 띄우고 chatRoomState update
  updateChatAction() async {
    print('2. update chatroom');
    String receiveUserId = StaticUser.userId == StaticChat.chatUserIds[0]
        ? StaticChat.chatUserIds[1]
        : StaticChat.chatUserIds[0];
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(StaticChat.chatRoomId)
        .update(
      {
        'lastChat': "${StaticUser.userName}님이 거래를 확정했습니다.",
        "sendUserId": StaticUser.userId,
        "receiveUserId": receiveUserId,
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
      },
    );
  }
}
