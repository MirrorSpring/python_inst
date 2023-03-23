import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Model/Chat/static_chat.dart';
import '../../Model/User/static_user.dart';
import '../../View/chat/chatroom_page.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({
    super.key,
    required this.poId,
    required this.poHeart,
    required this.poTitle,
    required this.poContent,
    required this.poPrice,
    required this.poImage1,
    // required this.poImage2,
    required this.poViews,
    // required this.initdate,poImage1
    required this.poUser,
    required this.poUserId,
    required this.userAddress,
    required this.userReliability,
  });
  final int poId;
  final int poHeart;
  final String poTitle;
  final String poContent;
  final String poPrice;
  final String poImage1;
  // final String poImage2;
  final int poViews;
  final String poUser;
  final String poUserId;
  final String userAddress;
  final int userReliability;
  // final int poPrice;
  // final int poPrice;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late Icon heart = const Icon(Icons.favorite_border);
  bool heartState = true;
  late String text = widget.poImage1;
  late int poId = widget.poId;
  late String userId = "korea";
  late int heartbeat = 0;
  // late Uri url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // StreamBuilder(
      future: imageslect(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          // 데이터가 비어 있을 수도 있으니까
          return const CircularProgressIndicator();
          // 비어있으면 빙글빙글 돌리기
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    width: 300,
                    height: 255,
                    child: Column(
                      children: [
                        Image.network(
                          "http://localhost:8080/images/$text",
                          fit: BoxFit.fill,
                          width: 300,
                          height: 250,
                        ),
                      ],
                    )),
                Container(
                  color: Colors.white,
                  width: 350,
                  height: 70,
                  child: Row(
                    children: [
                      Text("작성자 : ${widget.poUser} \n${widget.userAddress}",
                          style: const TextStyle(fontSize: 20)),
                      // Text("No : ${widget.poId}"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          "조회 : ${widget.poViews} 온도 : ${widget.userReliability}'C",
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  width: 350,
                  height: 60,
                  child: Column(
                    children: [
                      Text(
                        widget.poTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.poContent,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: const Text("신고하기"),
                ),
                Text("좋아요 : ${widget.poHeart}  조회 : ${widget.poViews}"),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.black, width: 0.5),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          heartState = !heartState;
                          // true = import
                          // false = import
                          setState(() {});
                          heartState ? loveHeart() : brokenHeart();

                          // poHeart +1 ,, wish에 UserID & PostID & now()
                          // heartNum == 0 ? heart : heart = Icon(Icons.favorite);
                        },
                        icon: heartState ? const Icon(Icons.favorite) : heart,
                        // ? True : False
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 80,
                      // color: Colors.green,
                      child: Row(
                        children: [
                          Text(
                            "   가격 :  ${widget.poPrice}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // 채팅하기 누르면 1대1 채팅방으로 이동
                          ElevatedButton(
                            onPressed: () {
                              StaticChat.chatUserIds = [
                                StaticUser.userId,
                                widget.poUserId
                              ];
                              StaticChat.chatUserNames = [
                                StaticUser.userName,
                                widget.poUser
                              ];

                              checkRoomExist(widget.poUserId, widget.poUser);
                            },
                            child: const Text("채팅하기"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), // == 버튼 로우 ==
              ],
            ), // 전체 Column
          );
        }
      },
    );
  } //

  // 이미지 이름 기져오기
  Future imageslect() async {
    await Future.delayed(const Duration(milliseconds: 500));
    String imagetext = widget.poImage1;
    var url = await Uri.parse('http://localhost:8080/images/$imagetext');
    checkWish();
    return url;
  }

  //
  // 좋아요 + 1
  Future loveHeart() async {
    int poId = widget.poId;
    var url =
        await Uri.parse('http://localhost:8080/post/heartPlus?poId=$poId');
    await http.get(url);
    // poHeart +1 해주고
    importWish(poId);
    // import wish userID, poId, update(now) 해주고
  }

  // 즐겨찾기 등록하기
  Future importWish(poId) async {
    var url = await Uri.parse(
        'http://localhost:8080/post/WishInsert?U_userId=$userId&P_poId=$poId');
    await http.get(url);
  }

// =======
  // 좋아요 1개 내리기
  Future brokenHeart() async {
    int poId = widget.poId;
    var url = await Uri.parse('http://localhost:8080/post/heartDiv?poId=$poId');
    await http.get(url);
    deleteWish(poId);
  } //

  // 즐겨찾기  삭제하기
  Future deleteWish(poId) async {
    // /deleteWish/{userId}/{poId}
    int poId = widget.poId;
    var url = await Uri.parse('http://localhost:8080/deleteWish/$userId/$poId');
    await http.get(url);
  }

  // 좋아요 즐겨찾기 등록한 게시물인지 체크해용
  Future<int> checkWish() async {
    int poId = widget.poId;
    var url =
        await Uri.parse('http://localhost:8080/post/selectWishlist?poId=$poId');
    var respnse = await http.get(url);
    var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
    heartbeat = dataConvertedJson;
    // heartbeat == 0 ? heartState = false : "";
    if (heartbeat != 1) {
      heartState = false;
    }
    return heartbeat;
  } //

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
          StaticChat.boardId = widget.poId;
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
      StaticChat.boardId = widget.poId;
      // StaticChat.chatRoomId = "";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomPage(),
        ),
      );
    }
  }
}

/// END
