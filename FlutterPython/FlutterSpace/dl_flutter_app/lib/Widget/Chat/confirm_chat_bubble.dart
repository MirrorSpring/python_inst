import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dl_flutter_app/Model/Chat/chat.dart';
import 'package:dl_flutter_app/Model/Chat/static_chat.dart';
import 'package:dl_flutter_app/Style/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../Model/User/static_user.dart';
// import '../../View/review/review_page.dart';

class ConfirmChatBubble extends StatefulWidget {
  final Chat chat;
  final String kindOfChat;

  const ConfirmChatBubble(
      {super.key, required this.chat, required this.kindOfChat});

  @override
  State<ConfirmChatBubble> createState() => _ConfirmChatBubbleState();
}

class _ConfirmChatBubbleState extends State<ConfirmChatBubble> {
  late bool confirmState;
  late String receiveId;
  // late int count;

  @override
  void initState() {
    super.initState();
    confirmState = StaticChat.confirmState;
    receiveId = StaticUser.userId == StaticChat.chatUserIds[0]
        ? StaticChat.chatUserIds[1]
        : StaticChat.chatUserIds[0];
    // count = 0;

    // if (count > 1) {
    //   confirmState = !confirmState;
    // }
    print("init: $confirmState");
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
            confirmState
                ? IconButton(onPressed: () {}, icon: const Icon(Icons.check))
                : ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.backgroundGreen,
                      ),
                    ),
                    onPressed: () {
                      confirmChat().then((value) => updateChatAction());
                      StaticChat.confirmState = !confirmState;
                      // count += 1;
                      setState(() {});
                    },
                    child: Text(
                      "거래 확정",
                      style: TextStyle(
                        color: CustomColors.pointColor,
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
    await FirebaseFirestore.instance
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
    // String receiveUserId = StaticUser.userId == StaticChat.chatUserIds[0]
    //     ? StaticChat.chatUserIds[1]
    //     : StaticChat.chatUserIds[0];
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(StaticChat.chatRoomId)
        .update(
      {
        'lastChat': "${StaticUser.userName}님이 거래를 확정했습니다.",
        "sendUserId": StaticUser.userId,
        "receiveUserId": receiveId,
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
      },
    );

    // setState(() {});
  }

  // refresh() {
  //   setState(() {});
  // }
}
