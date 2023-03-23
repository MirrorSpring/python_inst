import 'dart:convert';

import 'package:dl_flutter_app/View/board/uploadboard.dart';
import 'package:flutter/material.dart';
import '../../Model/board/Boardmodel.dart';
import '../../Widget/Alert/Alert.dart';
import '../../Widget/boardPage/boardPage.dart';
import 'package:http/http.dart' as http;

class PageDetail extends StatefulWidget {
  final board;
  final heartState2;
  const PageDetail(this.board, this.heartState2, {super.key});

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
  late String userId = "korea";
  late int heartbeat = 0;

  @override
  void initState() {
    super.initState();
    board = widget.board;
    // checkWish();
    print("=== 좋아요 한거면 true여야함.... ====");
    print(heartState);
    setState(() {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    // 유저가 게시글 작성자인지 확인
    bool isCurrentUserPostAuthor = board.u_userId == getCurrentUserId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40,
        centerTitle: true,
        // title: const Text(
        //   "작성글",
        //   style: TextStyle(color: Colors.black),
        // ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: const Text(
              "작성글",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          // 게시글 작성자일 경우만 Icon 출력
          if (isCurrentUserPostAuthor)
            IconButton(
              onPressed: () {
                // 삭제 : Deldate update
                int P_poId = board.poId;
                alert.Alert(context, P_poId);
              },
              icon: const Icon(Icons.delete),
            ),
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
                      poImage: board.poImage01,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.restore_page),
            )
        ],
      ),
      body: Stack(
        children: [
          Column(children: [
            SingleChildScrollView(
              controller: scroller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              child: BoardPage(
                  heartState: heartState,
                  poId: board.poId,
                  poHeart: board.poHeart,
                  poTitle: board.poTitle,
                  poContent: board.poContent,
                  poPrice: board.poPrice,
                  poImage1: board.poImage01,
                  // poImage2: board.poImage02,
                  poViews: board.poViews,
                  poUser: board.poUser,
                  userAddress: board.userAddress,
                  userReliability: board.userReliability),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 80,
                  child: Row(
                    children: [
                      Text(
                        "   가격 :  ${board.poPrice}",
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
                    //
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
    return 'korea'; // 임시로 korea 반환하도록 구현한 예시입니다.
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
  // Future<int> checkWish() async {
  //   int poId = board.poId;
  //   var url =
  //       await Uri.parse('http://localhost:8080/post/selectWishlist?poId=$poId');
  //   var respnse = await http.get(url);
  //   var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
  //   heartbeat = dataConvertedJson;
  //   // heartbeat == 0 ? heartState = false : "";
  //   if (heartbeat == 1) {
  //     heartState = true;
  //   }
  //   return heartbeat;
  // } //
} //
