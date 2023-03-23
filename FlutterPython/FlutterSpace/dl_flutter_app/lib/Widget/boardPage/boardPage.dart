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
  late String poUserId = widget.poUserId;
  late String userId = "korea";
  late int temp;
  late Color buttonColoc = Colors.white;
  late String buttonText = "판매완료";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = widget.userReliability;
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  child: Row(
                    children: [
                      Text("${widget.poUser} \n${widget.userAddress}",
                          style: const TextStyle(fontSize: 20)),
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.1),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
                  child: Text(
                    widget.poTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.3,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black, width: 0.5),
                  // ),
                  child: Text(
                    widget.poContent,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      detailButton(),
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
  detailButton() {
    if (poUserId == "korea") {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColoc, side: const BorderSide(width: 2)),
        onPressed: () {
          // 판매완료를 누르면
          // 포스트 상태 state 에 +1 해준다. 왜? 0 = 판매중 1 = 판매완료로 하고잇음
          StateChange();

          setState(() {
            buttonColoc = Colors.grey;
            buttonText = "판매완료등록";
          });
        },
        child: Text(buttonText,
            style: TextStyle(color: Colors.black, fontSize: 20)),
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

  Future StateChange() async {
    var url = Uri.parse('http://localhost:8080/post/poState?poId=$poId');
    await http.get(url);
  }
}

/// END
