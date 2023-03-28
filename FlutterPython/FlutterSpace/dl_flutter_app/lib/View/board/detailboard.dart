import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:dl_flutter_app/View/board/uploadboard.dart';
import 'package:flutter/material.dart';
import '../../Model/Chat/static_chat.dart';
import '../../Model/board/Boardmodel.dart';
import '../../Widget/Alert/Alert.dart';
import 'package:http/http.dart' as http;

import '../../Widget/boardPage/board_page.dart';
import '../chat/chatroom_page.dart';

class PageDetail extends StatefulWidget {
  final Board board;
  final bool heartState2;
  final String userid;
  const PageDetail(this.board, this.heartState2, this.userid, {super.key});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  ScrollController scroller = ScrollController();
  // 게시글 작성자일 경우만 Icon 출력
  late Icon heart = const Icon(Icons.favorite_border);
  late Board board;
  var alert = Alertclass();
  late bool heartState = widget.heartState2;
  late String userId = "";
  late int heartbeat = 0;

  @override
  void initState() {
    super.initState();
    board = widget.board;
    board.u_userId;
    userId = widget.userid;

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 유저가 게시글 작성자인지 확인
    bool isCurrentUserPostAuthor = userId == getCurrentUserId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40,
        centerTitle: true,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: const Text(
              "작성글",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          // 게시글 작성자일 경우만 수정, 삭제 Icon 출력
          if (isCurrentUserPostAuthor)
            IconButton(
              onPressed: () {
                // 삭제 : Deldate update
                int pPoid = board.poId;
                alert.Alert(context, pPoid);
              },
              icon: const Icon(Icons.delete),
            )
          else
            SizedBox(width: MediaQuery.of(context).size.width * 0.12),
          if (isCurrentUserPostAuthor)
            IconButton(
              onPressed: () {
                // 수정 :
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateBorad(
                      poId: board.poId,
                      poTitle: board.poTitle,
                      poContent: board.poContent,
                      poPrice: board.poPrice,
                      poInstrument: board.poInstrument,
                      poImage: board.poImage01,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.restore_page),
            )
          else
            SizedBox(width: MediaQuery.of(context).size.width * 0.12),
        ],
      ),
      body: Stack(
        children: [
          Column(children: [
            SingleChildScrollView(
              controller: scroller,
              physics: const AlwaysScrollableScrollPhysics(),
              child: BoardPage(
                heartState: heartState,
                poId: board.poId,
                poHeart: board.poHeart,
                poTitle: board.poTitle,
                poContent: board.poContent,
                poPrice: board.poPrice,
                poImage1: board.poImage01,
                poInstrument: board.poInstrument,
                poViews: board.poViews,
                poUser: board.poUser,
                userAddress: board.userAddress,
                userReliability: board.userReliability,
                poUserId: getCurrentUserId(),
              ),
              // CommandPage
              // Text("${board.poId}")\
            ),
          ]),

          Positioned(
            bottom: 0,
            child: Row(
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
                      setState(() {});
                      heartState ? loveHeart() : brokenHeart();
                    },
                    icon: heartState ? const Icon(Icons.favorite) : heart,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 80,
                  child: Row(
                    children: [
                      Text(
                        "가격 :  ${board.poPrice}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      // 채팅하기 누르면 1대1 채팅방으로 이동
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(width: 2)),
                  onPressed: () {
                    //채팅으로 넘어가는 버튼
                    checkRoomExist(
                        getCurrentUserId(), board.poUser, board.poId);
                  },
                  child: const Text(
                    "채팅하기",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ), // == 버튼 로우 ==
        ],
      ),
    );
  } //

  String getCurrentUserId() {
    // 현재 로그인한 사용자의 ID를 반환하는 함수
    // 이 함수는 실제로는 로그인 관련 로직을 구현해야 합니다.
    // 로그인할때 입력한거 저장해서 여기에 넣으면 될듯??
    return board.u_userId;
    // 임시로 korea 반환하도록 구현한 예시입니다.
  }

  //
  // 좋아요 + 1
  Future loveHeart() async {
    int poId = board.poId;
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
    int poId = board.poId;
    var url = await Uri.parse('http://localhost:8080/post/heartDiv?poId=$poId');
    await http.get(url);
    deleteWish(poId);
  } //

  // 즐겨찾기  삭제하기
  Future deleteWish(poId) async {
    // /deleteWish/{userId}/{poId}
    int poId = board.poId;
    var url = await Uri.parse('http://localhost:8080/deleteWish/$userId/$poId');
    await http.get(url);
  }

  // 좋아요 즐겨찾기 등록한 게시물인지 체크해용
  Future<int> checkWish() async {
    int poId = board.poId;
    var url =
        await Uri.parse('http://localhost:8080/post/selectWishlist?poId=$poId');
    var respnse = await http.get(url);
    var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
    heartbeat = dataConvertedJson;
    if (heartbeat == 1) {
      heartState = true;
    }
    return heartbeat;
  } //

  // 이미 존재하는 채팅방인지 확인
  checkRoomExist(String userId, String userName, int poId) async {
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
          StaticChat.boardId = poId;
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
      StaticChat.boardId = poId;
      // StaticChat.chatRoomId = "";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomPage(),
        ),
      );
    }
  }
} //
