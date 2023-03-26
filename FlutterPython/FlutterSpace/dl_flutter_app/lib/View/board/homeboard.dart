import 'dart:convert';

import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Model/board/Boardmodel.dart';
import '../../Model/board/boardlisttest.dart';
import 'Insertboard.dart';
import 'detailboard.dart';

class Homeboard extends StatefulWidget {
  const Homeboard({super.key, required this.searchText});
  final String searchText;
  @override
  State<Homeboard> createState() => _HomeboardState();

  void boardList() {}
}

class _HomeboardState extends State<Homeboard> {
  DateTime now = DateTime.now();
  late List data = [];
  late int poId = 0;
  late String searchText;
  ScrollController scroller = ScrollController();
  Boarder boarder = Boarder();
  var f = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');
  late int heartbeat = 0;
  late int heartbeat2 = 0;
  late String userid = "";
  late bool heartState = false;
  late bool heartState2 = false;
  @override
  void initState() {
    super.initState();
    searchText = widget.searchText;
    userid = StaticUser.userId;
    setState(() {
      checkWish(userid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: boardList(searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              // 데이터가 비어 있을 수도 있으니까
              return const CircularProgressIndicator();
              // 비어있으면 빙글빙글 돌리기
            } else {
              return Center(
                child: data.isEmpty
                    ? const Text('데이터가 없습니다')
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                poId = data[index]['poId'];
                                UpdateViews();
                                final board = Board(
                                    poId: data[index]['poId'],
                                    poHeart: data[index]['poHeart'],
                                    poTitle: data[index]['poTitle'],
                                    poContent: data[index]['poContent'],
                                    poPrice: data[index]['poPrice'],
                                    poImage01: data[index]['poImage01'],
                                    // poImage02: data[index]['poImage02'],
                                    poInstrument: data[index]['poInstrument'],
                                    poViews: data[index]['poViews'],
                                    poState: data[index]['poState'],
                                    // poUpDate : data[index]['poUpDate'],
                                    // timeonly : data[index]['timeonly'],
                                    u_userId: data[index]['u_userId'],
                                    poUser: data[index]['poUser'],
                                    userAddress: data[index]['userAddress'],
                                    userReliability: data[index]
                                        ['userReliability']);
                                setState(() {
                                  // 화면 새로 불러와서 조회수 오른거 보여주기
                                  // 근데 자기가 쓴 글 조회수 복사하는거 막아야함...
                                  // data.clear;
                                  // boardList();
                                });
                                wishlistcheck(poId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageDetail(
                                          board, heartState2, userid)),
                                );
                              },
                              child: SingleChildScrollView(
                                controller: scroller,
                                // physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Image.network(
                                            "http://localhost:8080/images/${data[index]['poImage01']}",
                                            // width: 90,
                                            // height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          height: 125,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                    child: Text(
                                                      "${data[index]['poTitle']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${data[index]['userAddress']} ${data[index]['poInstrument']}\n"
                                                      "${data[index]['poUpDate']}"),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    f.format(int.parse(
                                                        data[index]
                                                            ['poPrice'])),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  data[index]["poState"] != 0
                                                      ? const Text(
                                                          "판매완료",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey),
                                                        )
                                                      : const Text("판매중",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                  data[index]["poHeart"] != 0
                                                      ? Row(
                                                          children: [
                                                            if (heartbeat > 0)
                                                              const Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .red)
                                                            else
                                                              const Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            Text(
                                                                "${data[index]["poHeart"]}")
                                                          ],
                                                        )
                                                      : const Text(""),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertPage(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  // Stream<List> boardstart(String searchText) async* {
  //   await boarder.boardList(searchText);
  //   yield data;
  // }

  // 데이터를 초기화 한 후 게시글 출력
  Future<bool> wishlistcheck(poId) async {
    var url =
        await Uri.parse('http://localhost:8080/post/selectWishlist?poId=$poId');
    var respnse = await http.get(url);
    var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
    heartbeat2 = dataConvertedJson;
    // heartbeat == 0 ? heartState = false : "";
    if (heartbeat2 == 1) {
      heartState2 = true;
    } else {
      heartState2 = false;
    }
    return heartState2;
  } //

  boardList(searchText) {
    data.clear();
    setState(() {
      searchText = widget.searchText;
    });
    return boardList2(searchText);
  }

  // 게시글 목록 불러오기
  Stream<List> boardList2(searchText) async* {
    //searchText
    if (searchText.isEmpty) {
      var url = await Uri.parse('http://localhost:8080/post/alljoin_upload');
      // return url
      var respnse = await http.get(url);
      var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
      data.addAll(dataConvertedJson);
      yield data;
    } else {
      var url = await Uri.parse(
          'http://localhost:8080/post/searchBoard?Search=$searchText');
      var respnse = await http.get(url);
      var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
      data.addAll(dataConvertedJson);
      yield data;
    }
    // print("게시물목록 불러오기 성공");
  }

  // 게시글 누르면 조회수 1 증가.
  Future UpdateViews() async {
    // print(poId);
    var url = await Uri.parse('http://localhost:8080/post/views/$poId');
    await http.get(url);
    // print(url);
    return data;
  } //

  Future<int> checkWish(userid) async {
    String U_userId = userid;
    var url = await Uri.parse(
        'http://localhost:8080/post/checkWishlist?U_userId=$U_userId');
    var respnse = await http.get(url);
    var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
    heartbeat = dataConvertedJson;
    // heartbeat == 0 ? heartState = false : "";
    print(heartbeat);
    if (heartbeat >= 1) {
      heartState = true;
    }
    print(heartState);
    return heartbeat;
  } //
} //
