import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

import '../Model/Chat/chat.dart';
import '../Model/Chat/static_chat.dart';
import '../Model/static_user.dart';
import '../Widget/AppBar/custom_app_bar.dart';
import '../Widget/Chat/chat_bubble.dart';
import '../Widget/Chat/chat_floating_bar.dart';
import '../Widget/Chat/chat_input_tf.dart';

import 'package:image_picker/image_picker.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late String chatRoomId;
  late TextEditingController tfChatController;
  //이미지 업로드를 위해
  late ImagePicker picker;

  var image;
  // var userImage;
  late bool imageState;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late File file;

  //이미지 출력
  late String imageUrlString;

  @override
  void initState() {
    super.initState();
    chatRoomId = StaticChat.chatRoomId;
    tfChatController = TextEditingController();
    picker = ImagePicker();
    imageState = false;
    file = File("");

    imageUrlString = "";

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
              .orderBy("chatTime", descending: true)
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
                              image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              // Xfile -> file로 변환
                              file = File(image.path);
                              // Image(
                              //   image: AssetImage('assets/images/my_image.png'),
                              // );

                              imageState = true;

                              setState(() {});

                              print("file: $file");
                            },
                            icon: const Icon(Icons.photo),
                          ),
                          ChatInputTf(tfChatController: tfChatController),
                          // -------------------------------------- 채팅 전송 버튼 **
                          IconButton(
                            color: const Color(0xff9AB6FF),
                            onPressed: () async {
                              //db insert
                              addChatAction();
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
                  child: ChatFloatingBar(
                    userId: StaticUser.userId == StaticChat.chatUserIds[0]
                        ? StaticChat.chatUserIds[1]
                        : StaticChat.chatUserIds[0],
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
        photoUrl: doc['photoUrl']);

    // drawImage(chat.photoUrl);

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
          mainAxisAlignment: chat.sendUserId == StaticUser.userId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
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
    // 채팅을 insert 함
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

  // 채팅방을 만듦
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
        'lastChat': tfChatController.text,
        "sendUserId": StaticUser.userId,
        "receiveUserId": StaticUser.userId == StaticChat.chatUserIds[0]
            ? StaticChat.chatUserIds[1]
            : StaticChat.chatUserIds[0],
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
      }),
    ).then((value) => chatRefresh());
  }

  chatRefresh() {
    print('4. refresh');
    setState(() {});
    tfChatController.text = "";
  }

  // image upload
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

  // Future drawImage(String photoUrl) async {
  //   //
  //   final storage = FirebaseStorage.instance;

  //   Reference ref = storage.refFromURL(photoUrl);
  //   String downloadUrl = await ref.getDownloadURL();
  //   imageUrlString = downloadUrl.toString();
  //   // return imageUrlString;
  // }
} //END
