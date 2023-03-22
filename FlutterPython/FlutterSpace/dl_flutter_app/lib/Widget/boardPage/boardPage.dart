import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String userAddress;
  final int userReliability;
  // final int poPrice;
  // final int poPrice;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late Icon heart = const Icon(Icons.favorite_border);
  late bool heartState;
  late String text = widget.poImage1;
  // late Uri url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heartState = false;
    imageslect();

    // imageslect();
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
                    height: 300,
                    child: Column(
                      children: [
                        Image.network("http://localhost:8080/images/$text"),
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
                        "${widget.poTitle}",
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
                        "내용 : ${widget.poContent}",
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
                          setState(() {});
                          // heartNum == 0 ? heart : heart = Icon(Icons.favorite);
                        },
                        icon: heartState ? Icon(Icons.favorite) : heart,
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
                              //
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

  Future imageslect() async {
    // print(poId);
    String imagetext = widget.poImage1;
    var url = await Uri.parse('http://localhost:8080/images/$imagetext');
    return url;
  }
}

/// END
