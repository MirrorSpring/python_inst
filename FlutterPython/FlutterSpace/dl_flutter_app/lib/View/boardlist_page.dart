import 'package:flutter/material.dart';
import 'board/Declaration.dart';
import 'board/homeboard.dart';
import 'package:http/http.dart' as http;
import '../Model/board/boardlisttest.dart';

class BoardListPage extends StatefulWidget {
  const BoardListPage({super.key});

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  late TextEditingController selectController = TextEditingController();
  late TextEditingController val1 = TextEditingController();
  late String searchTexts = "";
  late List data = [];
  late int poId = 0;
  Boarder boardstartI = Boarder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40,
        actions: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                color: Colors.white,
                child: TextField(
                  controller: selectController,
                  onChanged: (text) {
                    searchTexts = selectController.text;
                    setState(() {
                      //
                    });
                  },
                  decoration: const InputDecoration(hintText: "검색"),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                searchTexts = selectController.text;
                setState(() {});
              },
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                // 공지사항으로 이동
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Declaration()),
                    ));
              },
              icon: const Icon(Icons.notifications),
              color: Colors.black,
            ),
          ]),
        ],
      ),
      body: Homeboard(
        searchText: searchTexts,
      ),
    );
  } //

//   // 검색
//   // 2023 - 03 - 21 - 화요일
//   // 박태권
//   // searchboard() {}
//   // 데이터를 초기화 한 후 게시글 출력
//   // // 게시글 누르면 조회수 1 증가.
//   // Future UpdateViews() async {
//   //   // print(poId);
//   //   var url = await Uri.parse('http://localhost:8080/post/views/$poId');
//   //   await http.get(url);
//   //   // print(url);
//   //   return data;
//   // }
} // END
