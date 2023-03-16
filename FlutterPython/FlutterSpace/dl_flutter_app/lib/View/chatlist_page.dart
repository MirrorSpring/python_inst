import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Chat/chatroom.dart';
import '../Model/Chat/static_chat.dart';
import '../Model/Chat/static_user.dart';
import '../Widget/AppBar/custom_app_bar.dart';
import 'chatroom_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "채팅", centerTitle: true, appBar: AppBar()),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .where("userIds", arrayContains: StaticUser.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CupertinoActivityIndicator());
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: documents.map((e) => _buildItemWidget(e)).toList(),
          );
        },
      ),
    );
  }

  // functions -----
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final chatRoom = ChatRoom(
      chatRoomId: doc.id,
      chatRoomState: doc['chatRoomState'],
      lastChat: doc['lastChat'],
      userIds: doc['userIds'],
      userNames: doc['userNames'],
    );

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) {
        //삭제
        FirebaseFirestore.instance.collection('chatroom');
      },
      child: GestureDetector(
        onTap: () {
          StaticChat.chatRoomId = chatRoom.chatRoomId;
          StaticChat.chatUserIds = chatRoom.userIds;
          StaticChat.chatUserNames = chatRoom.userNames;

          updateChatRoomStateAction(chatRoom.chatRoomId);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatRoomPage(),
            ),
          );
        },
        child: Card(
          child: ListTile(
            title: Text(
              '${chatRoom.userNames[0] == StaticUser.userName ? chatRoom.userNames[1] : chatRoom.userNames[0]}',
            ),
            subtitle: Text(chatRoom.lastChat),
            trailing: chatRoom.chatRoomState
                ? const Icon(Icons.wechat)
                : const Icon(Icons.wechat, color: Colors.red),
          ),
        ),
      ),
    );
  }

  // 채팅방 읽었다고 업데이트
  updateChatRoomStateAction(String chatRoomId) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .update({'chatRoomState': true});
  }
}
