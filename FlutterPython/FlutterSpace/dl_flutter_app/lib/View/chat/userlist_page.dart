import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/Chat/static_chat.dart';
import '../../Model/User/static_user.dart';
import '../../Model/User/user.dart';
import 'chatroom_page.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late TextEditingController tfUserName;
  late TextEditingController tfUserReliability;
  late TextEditingController tfUserPw;
  final Color mainColor = const Color.fromARGB(255, 174, 195, 250);

  @override
  void initState() {
    super.initState();
    tfUserName = TextEditingController();
    tfUserReliability = TextEditingController();
    tfUserPw = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("유저 리스트"), actions: [
        IconButton(
          onPressed: () {
            _showDialog(context);
          },
          icon: const Icon(Icons.add),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
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

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final users = User(
        userId: doc.id,
        userName: doc['userName'],
        userReliability: doc['userReliability']);

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
          StaticChat.chatUserIds = [StaticUser.userId, users.userId];
          StaticChat.chatUserNames = [StaticUser.userName, users.userName];

          checkRoomExist(users.userId, users.userName);
        },
        child: Card(
          child: ListTile(
            title: Text(users.userName),
          ),
        ),
      ),
    );
  }

  checkRoomExist(String userId, String userName) async {
    FirebaseFirestore fs = FirebaseFirestore.instance;

    final Query query1 = fs
        .collection('chatroom')
        .where("sendUserId", isEqualTo: StaticUser.userId)
        .where("receiveUserId", isEqualTo: userId);

    final Query query2 = fs
        .collection("chatroom")
        .where("sendUserId", isEqualTo: userId)
        .where("receiveUserId", isEqualTo: StaticUser.userId);

    final QuerySnapshot querySnapshot1 = await query1.get();
    final QuerySnapshot querySnapshot2 = await query2.get();
    final int count1 = querySnapshot1.size;
    final int count2 = querySnapshot2.size;
    final bool chatRoomExist = (count1 + count2) == 0 ? false : true;

    print(count1 + count2);

    // 이미 존재하는 채팅방이라면 Static에 채팅방 문서 id 넘겨주기
    if (chatRoomExist) {
      print('이미 채팅방이 존재!');
      for (var doc in [querySnapshot1.docs, querySnapshot2.docs]) {
        for (var document in doc) {
          StaticChat.chatRoomId =
              document.id.isEmpty ? StaticChat.chatRoomId : document.id;
          StaticChat.chatUserIds = document['userIds'] == []
              ? StaticChat.chatUserIds
              : document['userIds'];
          StaticChat.chatUserNames = document['userNames'] == []
              ? StaticChat.chatUserNames
              : document['userNames'];
          print('Document ID: ${document.id}');
          print('userIds: ${StaticChat.chatUserIds}');
          print('userNames: ${StaticChat.chatUserNames}');
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomPage(),
        ),
      );
    } else {
      // 존재하지 않는다면 빈 채팅방 페이지만 띄우기
      print("채팅방이 존재하지 않으므로 빈 페이지를 띄웁니다!");
      StaticChat.chatRoomId = "none";
      StaticChat.chatUserIds = [StaticUser.userId, userId];
      StaticChat.chatUserNames = [StaticUser.userName, userName];
      // StaticChat.chatRoomId = "";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomPage(),
        ),
      );
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('입력'),
          content: Column(
            children: [
              TextField(
                controller: tfUserName,
                decoration: const InputDecoration(labelText: "user name"),
              ),
              TextField(
                controller: tfUserPw,
                decoration: const InputDecoration(labelText: "pw"),
              ),
              TextField(
                controller: tfUserReliability,
                decoration: const InputDecoration(labelText: "reliability"),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    addUser();
                    Navigator.of(ctx).pop();
                    // setState(() {});
                  },
                  child: const Text(
                    '입력',
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  addUser() {
    FirebaseFirestore.instance.collection("user").add({
      "userName": tfUserName.text,
      "userPw": tfUserPw.text,
      "userReliability": int.parse(tfUserReliability.text),
      // "chatRoomState": false,
    });
  }
}
