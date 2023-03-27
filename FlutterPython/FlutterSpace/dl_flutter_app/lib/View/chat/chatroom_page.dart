import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dl_flutter_app/Style/custom_colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../Model/Chat/chat.dart';
import '../../Model/Chat/static_chat.dart';
import '../../Model/User/static_user.dart';
import '../../Widget/AppBar/custom_app_bar.dart';
import '../../Widget/Chat/chat_bubble.dart';
import '../../Widget/Chat/chat_floating_bar.dart';
import '../../Widget/Chat/chat_input_tf.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late String chatRoomId;
  late TextEditingController tfChatController;
  //이미지 업로드를 위해
  late ImagePicker picker; //갤러리 사용하기 위함
  var image;
  late bool imageState; // 이미지가 선택되어 있으면 이미지 컨테이너를 띄우기 위해
  FirebaseStorage storage = FirebaseStorage.instance;
  late File file;

  @override
  void initState() {
    super.initState();
    chatRoomId = StaticChat.chatRoomId;
    tfChatController = TextEditingController();
    picker = ImagePicker();
    imageState = false;
    file = File("");

    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: StaticChat.chatUserNames[0] == StaticUser.userName
              ? StaticChat.chatUserNames[1]
              : StaticChat.chatUserNames[0],
          centerTitle: false,
          appBar: AppBar(),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chatroom')
              .doc(chatRoomId)
              .collection('chat')
              .orderBy('chatTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('data 없음');
              return const Center(child: CupertinoActivityIndicator());
            } else {
              print('data가 존재');
              if (image != null) {}
            }
            final documents = snapshot.data!.docs;

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true, // listview를 밑에서부터 채우기
                        children:
                            documents.map((e) => _buildItemWidget(e)).toList(),
                      ),
                    ),
                    // 만약에 image를 가져왔으면 image를 보여주고 아니면 빈 컨테이너를 리턴

                    if (imageState)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Image.file(File(image.path)),
                      )
                    else
                      Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5),
                          IconButton(
                            color: (Colors.grey),
                            onPressed: () async {
                              // gallery
                              print("image state: $imageState");
                              image = await picker.getImage(
                                  source: ImageSource.gallery);

                              print("image: $image");

                              if (image != null) {
                                // Xfile -> file로 변환
                                file = File(image.path);

                                imageState = true;
                                print("file: $file");

                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.photo),
                          ),
                          ChatInputTf(tfChatController: tfChatController),
                          // -------------------------- 채팅 전송 버튼 **
                          IconButton(
                            color: CustomColors.mainColor,
                            onPressed: () async {
                              //db insert
                              addChatAction();
                              image = null;
                              imageState = false;
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    // floating bar
                    child: ChatFloatingBar(
                      userId: StaticUser.userId == StaticChat.chatUserIds[0]
                          ? StaticChat.chatUserIds[1]
                          : StaticChat.chatUserIds[0],
                      poId: StaticChat.boardId,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  //functions -----
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final chat = Chat(
      chatId: doc.id,
      chatText: doc['chatText'],
      chatTime: doc['chatTime'].toDate(),
      sendUserId: doc['sendUserId'],
      photoUrl: doc['photoUrl'],
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
        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(chatRoomId)
            .collection('chat')
            .doc(doc.id)
            .delete();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // 내가 보낸 채팅은 오른쪽 정렬(end), 받은 채팅은 왼쪽 정렬(start)
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: chat.sendUserId == StaticUser.userId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            //저장된 이미지가 없으면 chatBubble 띄우고 있으면 이미지 띄우기
            chat.photoUrl == ""
                ? ChatBubble(chat: chat)
                : SizedBox(
                    width: 250,
                    child: Image.network(chat.photoUrl),
                  ),
          ],
        ),
      ),
    );
  }

  // 채팅을 보냄
  addChatAction() async {
    // chatRoomId 가 없으면 일단 채팅방을 만들고
    if (tfChatController.text.trim() != "") {
      if (chatRoomId == "none") {
        await addChatRoomAction();
        // 있으면 바로 채팅을 보낸다
      } else {
        addChatBubble();
        await updateChatAction();
      }
    }

    // 이미지를 보냈으면 upload file -> update chatroom
    // 마지막 채팅을 "사진을 보냄"으로 update
    if (image != null) {
      uploadFile();
      image = null;
      imageState = false;
      await updateChatAction();
    }
  }

  // 채팅을 insert
  addChatBubble() {
    print('3. chat insert');
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .add({
      'sendUserId': StaticUser.userId,
      'chatTime': DateTime.now(),
      'chatText': tfChatController.text,
      'photoUrl': "",
    });
  }

  // 만들어진 docId를 select
  Future selectDocId() async {
    final Query query = FirebaseFirestore.instance
        .collection('chatroom')
        .where("sendUserId", isEqualTo: StaticUser.userId)
        .where("receiveUserId",
            isEqualTo: StaticUser.userId == StaticChat.chatUserIds[0]
                ? StaticChat.chatUserIds[1]
                : StaticChat.chatUserIds[0]);
    final QuerySnapshot querySnapshot = await query.get();
    for (var document in querySnapshot.docs) {
      print('2. 만들어진 chatRoom의 docId를 select: ${document.id}');
      chatRoomId = document.id;
    }
  }

  // 채팅방을 만듦 (insert)
  addChatRoomAction() async {
    Future(() {
      print('1. 채팅방을 만들고');
      FirebaseFirestore.instance.collection("chatroom").add({
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
        "sendUserId": StaticUser.userId,
        "receiveUserId": StaticUser.userId == StaticChat.chatUserIds[0]
            ? StaticChat.chatUserIds[1]
            : StaticChat.chatUserIds[0],
        "lastChat": tfChatController.text,
        "userIds": StaticChat.chatUserIds,
        "userNames": StaticChat.chatUserNames,
        "poId": StaticChat.boardId,
      });
    })
        .then((value) => selectDocId())
        .then((value) => addChatBubble())
        .then((value) => chatRefresh());
  }

  // 채팅방 목록에 가장 최근 채팅 띄우고 chatRoomState update
  updateChatAction() {
    print('update chatroom');
    Future(
      () => FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatRoomId)
          .update({
        'lastChat':
            tfChatController.text == "" ? "사진을 보냄" : tfChatController.text,
        "sendUserId": StaticUser.userId,
        "receiveUserId": StaticUser.userId == StaticChat.chatUserIds[0]
            ? StaticChat.chatUserIds[1]
            : StaticChat.chatUserIds[0],
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
      }),
    ).then((value) => chatRefresh());
  }

  // refresh하는 메소드
  chatRefresh() {
    print('4. refresh');
    setState(() {});
    tfChatController.text = "";
  }

  // image upload to firebase
  Future uploadFile() async {
    if (image == null) return;

    final storageRef = FirebaseStorage.instance.ref();

    final fileName = basename(file.path);
    final mountainImagesRef = storageRef.child("images/$fileName");

    await mountainImagesRef.putFile(file);

    String imageUrl = "gs://dl-flutter.appspot.com/images/$fileName";
    Reference ref = storage.refFromURL(imageUrl);
    String downloadUrl = await ref.getDownloadURL();

    print("file2: $file");
    print("filename: $fileName");
    print("ref: $mountainImagesRef");

    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .add({
      'sendUserId': StaticUser.userId,
      'chatTime': DateTime.now(),
      'chatText': "사진을 보냄",
      'photoUrl': downloadUrl,
    });
  }
} //END
