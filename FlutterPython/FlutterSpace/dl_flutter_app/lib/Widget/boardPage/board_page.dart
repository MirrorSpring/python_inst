import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/User/static_user.dart';
import '../Alert/image.dart';
import 'package:http/http.dart' as http;

class BoardPage extends StatefulWidget {
  const BoardPage({
    super.key,
    required this.heartState,
    required this.poId,
    required this.poHeart,
    required this.poTitle,
    required this.poContent,
    required this.poPrice,
    required this.poImage1,
    required this.poInstrument,
    required this.poViews,
    // required this.initdate,poImage1
    required this.poUser,
    required this.poUserId,
    required this.userAddress,
    required this.userReliability,
  });
  final bool heartState;
  final int poId;
  final int poHeart;
  final String poTitle;
  final String poContent;
  final String poPrice;
  final String poImage1;
  final String poInstrument;
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
  Imagetemp imagetemp = Imagetemp();
  late Icon heart = const Icon(Icons.favorite_border);
  late String text = widget.poImage1;
  late int poId = widget.poId;
  late String poUserId = widget.poUserId;
  late String userId = "";
  late int temp;
  late Color buttonColoc = Colors.white;
  late String buttonText = "상태변경";
  late String chatRoomId;
  late List userIds;

  @override
  void initState() {
    super.initState();
    temp = widget.userReliability;
    userId = StaticUser.userId;
    chatRoomId = "";
    userIds = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imageslect(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          // 데이터가 비어 있을 수도 있으니까
          return const CircularProgressIndicator();
          // 비어있으면 빙글빙글 돌리기
        } else {
          return Stack(children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.network(
                    "http://localhost:8080/images/$text",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 60,
                  child: Row(
                    children: [
                      Text("${widget.poUser} \n${widget.userAddress}",
                          style: const TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                      ),
                      Text("${widget.userReliability}'C",
                          style: const TextStyle(fontSize: 20)),
                      imagetemp.tempImage(temp),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.1),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 45,
                  child: Text(
                    widget.poTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    widget.poContent,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    children: [
                      detailButton(userId),
                      //
                      Text("   관심 : ${widget.poHeart}  조회 : ${widget.poViews}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ]);
        }
      },
    );
  } //

  // 이미지 이름 기져오기
  Future imageslect() async {
    await Future.delayed(const Duration(milliseconds: 500));
    String imagetext = widget.poImage1;
    var url = await Uri.parse('http://localhost:8080/images/$imagetext');
    // checkWish();
    return url;
  }

  // 작성한 게시글이면 버튼 바꿔서 출력. /post/poState
  detailButton(userId) {
    String useridd = userId;
    if (poUserId == useridd) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColoc, side: const BorderSide(width: 2)),
        onPressed: () {
          // 판매완료를 누르면
          // 포스트 상태 state 에 +1 해준다. 왜? 0 = 판매중 1 = 판매완료로 하고잇음
          stateChange();
          // 거래 완료 채팅을 보냅니다.
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 2)),
                        onPressed: () {
                          stateChange();
                          Navigator.pop(context);
                        },
                        child: const Text("판매완료",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 2)),
                        onPressed: () {
                          stateChange();
                          Navigator.pop(context);
                        },
                        child: const Text("판매중",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 2)),
                        onPressed: () {
                          stateChange();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "거래중",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          selectChatRoomID()
              .then((value) => confirmChat())
              .then((value) => updateChatAction());

          setState(() {
            // buttonColoc = Colors.grey;
            // buttonText = "판매완료등록";
          });
        },
        child: Text(buttonText,
            style: const TextStyle(color: Colors.black, fontSize: 20)),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, side: const BorderSide(width: 2)),
        onPressed: () {
          //
        },
        child: const Text(
          "신고하기",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }
  } //

  // 거래 완료 등 상태표시
  Future stateChange() async {
    var url = Uri.parse('http://localhost:8080/post/poState?poId=$poId');
    await http.get(url);
  }

  // for 채팅 ======================================
  // chatRoomId를 poId로 select
  Future<bool> selectChatRoomID() async {
    print('1. select room id');
    // poId가 똑같은 채팅방을 select 합니다.
    await FirebaseFirestore.instance
        .collection('chatroom')
        .where('poId', isEqualTo: poId)
        .get()
        .then(
      (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> documentSnapshots =
            querySnapshot.docs;
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in documentSnapshots) {
          Map<String, dynamic> data = documentSnapshot.data();
          userIds = data['userIds'];
          chatRoomId = documentSnapshot.id;
        }
      },
    );
    return true;
  }

  // 거래 완료 요청 채팅 보내기
  Future confirmChat() async {
    print('2. 거래 완료 요청 채팅 보내기');
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .add({
      'sendUserId': poUserId,
      'chatTime': DateTime.now(),
      'chatText': "${widget.poUser}님이 거래 확정을 요청했습니다.",
      'photoUrl': "",
    });
  }

  // 채팅방 목록에 가장 최근 채팅 띄우고 chatRoomState update
  updateChatAction() async {
    print('3. update chatroom');
    print("chatRoomId: $chatRoomId");
    String receiveUserId =
        StaticUser.userId == userIds[0] ? userIds[1] : userIds[0];
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .update(
      {
        'lastChat': "${widget.poUser}님이 거래 확정을 요청했습니다.",
        "sendUserId": StaticUser.userId,
        "receiveUserId": receiveUserId,
        "sendChatRoomState": true,
        "receiveChatRoomState": false,
      },
    );
  }
}//END

