import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Model/Chat/static_chat.dart';
import '../Alert/image.dart';

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
    // required this.poImage2,
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
  Imagetemp imagetemp = Imagetemp();
  late Icon heart = const Icon(Icons.favorite_border);
  late String text = widget.poImage1;
  late int poId = widget.poId;
  // late bool heartState = widget.heartState;
  late String userId = "korea";
  // late int heartbeat = 0;
  late int temp;
  // late Uri url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = widget.userReliability;
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
          return Stack(children: [
            Column(
              children: [
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      children: [
                        Image.network(
                          "http://localhost:8080/images/$text",
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ],
                    )),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  child: Row(
                    children: [
                      Text("${widget.poUser} \n${widget.userAddress}",
                          style: const TextStyle(fontSize: 20)),
                      // Text("No : ${widget.poId}"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
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
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.9,
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
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.3,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black, width: 0.5),
                  // ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(width: 2)),
                        onPressed: () {
                          //
                        },
                        child: const Text("신고하기",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      Text("   관심 : ${widget.poHeart}  조회 : ${widget.poViews}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 0,
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 60,
            //         height: 60,
            //         decoration: const BoxDecoration(
            //           border: Border(
            //             right: BorderSide(color: Colors.black, width: 0.5),
            //           ),
            //         ),
            //         child: IconButton(
            //           onPressed: () {
            //             heartState = !heartState;
            //             setState(() {});
            //             heartState ? loveHeart() : brokenHeart();
            //           },
            //           icon: heartState ? const Icon(Icons.favorite) : heart,
            //           color: Colors.red,
            //         ),
            //       ),
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.5,
            //         height: 80,
            //         child: Row(
            //           children: [
            //             Text(
            //               "   가격 :  ${widget.poPrice}",
            //               style: const TextStyle(
            //                   fontSize: 20, fontWeight: FontWeight.bold),
            //             ),
            //             // 채팅하기 누르면 1대1 채팅방으로 이동
            //           ],
            //         ),
            //       ),
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.white,
            //             side: const BorderSide(width: 2)),
            //         onPressed: () {
            //           //
            //         },
            //         child: const Text(
            //           "채팅하기",
            //           style: TextStyle(color: Colors.black, fontSize: 20),
            //         ),
            //       ),
            //     ],
            //   ),
            // ), // == 버튼 로우 ==
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

//   //
//   // 좋아요 + 1
//   Future loveHeart() async {
//     int poId = widget.poId;
//     var url =
//         await Uri.parse('http://localhost:8080/post/heartPlus?poId=$poId');
//     await http.get(url);
//     // poHeart +1 해주고
//     importWish(poId);
//     // import wish userID, poId, update(now) 해주고
//   }

//   // 즐겨찾기 등록하기
//   Future importWish(poId) async {
//     var url = await Uri.parse(
//         'http://localhost:8080/post/WishInsert?U_userId=$userId&P_poId=$poId');
//     await http.get(url);
//   }

// // =======
//   // 좋아요 1개 내리기
//   Future brokenHeart() async {
//     int poId = widget.poId;
//     var url = await Uri.parse('http://localhost:8080/post/heartDiv?poId=$poId');
//     await http.get(url);
//     deleteWish(poId);
//   } //

//   // 즐겨찾기  삭제하기
//   Future deleteWish(poId) async {
//     // /deleteWish/{userId}/{poId}
//     int poId = widget.poId;
//     var url = await Uri.parse('http://localhost:8080/deleteWish/$userId/$poId');
//     await http.get(url);
//   }

  // // 좋아요 즐겨찾기 등록한 게시물인지 체크해용
  // Future<int> checkWish() async {
  //   int poId = widget.poId;
  //   var url =
  //       await Uri.parse('http://localhost:8080/post/selectWishlist?poId=$poId');
  //   var respnse = await http.get(url);
  //   var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
  //   heartbeat = dataConvertedJson;
  //   // heartbeat == 0 ? heartState = false : "";
  //   if (heartbeat != 1) {
  //     heartState = false;
  //   }
  //   return heartbeat;
  // } //
}

/// END
