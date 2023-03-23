import 'package:dl_flutter_app/View/board/uploadboard.dart';
import 'package:flutter/material.dart';
import '../../Model/board/Boardmodel.dart';
import '../../Widget/Alert/Alert.dart';
import '../../Widget/boardPage/boardPage.dart';
import '../../tabbar.dart';

class PageDetail extends StatefulWidget {
  final board;
  const PageDetail(this.board, {super.key});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  ScrollController scroller = ScrollController();
  // 게시글 작성자일 경우만 Icon 출력
  late Board board;
  var alert = Alertclass();

  @override
  void initState() {
    super.initState();
    board = widget.board;
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
        title: const Text(
          "작성글",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
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
      body: SingleChildScrollView(
        controller: scroller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            BoardPage(
                poId: board.poId,
                poHeart: board.poHeart,
                poTitle: board.poTitle,
                poContent: board.poContent,
                poPrice: board.poPrice,
                poImage1: board.poImage01,
                // poImage2: board.poImage02,
                poViews: board.poViews,
                poUser: board.poUser,
                poUserId: getCurrentUserId(),
                userAddress: board.userAddress,
                userReliability: board.userReliability),
            // CommandPage
            // Text("${board.poId}")
          ],
        ),
      ),
    );
  } //

  String getCurrentUserId() {
    // 현재 로그인한 사용자의 ID를 반환하는 함수
    // 이 함수는 실제로는 로그인 관련 로직을 구현해야 합니다.
    // 로그인할때 입력한거 저장해서 여기에 넣으면 될듯??
    return 'korea'; // 임시로 korea 반환하도록 구현한 예시입니다.
  }
} //
