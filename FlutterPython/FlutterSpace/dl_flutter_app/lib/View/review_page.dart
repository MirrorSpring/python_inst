import 'dart:ffi';

import 'package:dl_flutter_app/DataHandler/review_handler.dart';
import 'package:dl_flutter_app/View/reviewlist_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../Model/Chat/static_chat.dart';
import '../Model/static_user.dart';
import '../Widget/AppBar/custom_app_bar.dart';

class ReviewPage extends StatefulWidget {
  final String userId;
  const ReviewPage({super.key, required this.userId});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late ReviewHandler handler;
  late TextEditingController tfReviewController;
  late Icon borderdStar;
  late Icon filledStar;
  late int starIndex;
  late Icon currentStar;
  final Color mainColor = const Color.fromARGB(255, 174, 195, 250);
  late String toUserId;

  @override
  void initState() {
    super.initState();
    print('userId: ${widget.userId}');
    handler = ReviewHandler();
    tfReviewController = TextEditingController();
    starIndex = 5;
    borderdStar = const Icon(Icons.star_border);
    filledStar = const Icon(Icons.star);
    currentStar = const Icon(Icons.star_border);
    toUserId = StaticChat.chatUserIds[0] == StaticUser.userId
        ? StaticChat.chatUserIds[1]
        : StaticChat.chatUserIds[0];
    // handler.selectRowCount(toUserId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
            CustomAppBar(title: "리뷰 작성", centerTitle: true, appBar: AppBar()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        starIndex = 1;
                        setState(() {});
                      },
                      icon: starIndex == 0 ? borderdStar : filledStar,
                      color: mainColor,
                    ),
                    IconButton(
                      onPressed: () {
                        starIndex = 2;
                        setState(() {});
                      },
                      icon: (starIndex == 0 || starIndex == 1)
                          ? borderdStar
                          : filledStar,
                      color: mainColor,
                    ),
                    IconButton(
                      onPressed: () {
                        starIndex = 3;
                        setState(() {});
                      },
                      icon: (starIndex == 0 || starIndex == 1 || starIndex == 2)
                          ? borderdStar
                          : filledStar,
                      color: mainColor,
                    ),
                    IconButton(
                      onPressed: () {
                        starIndex = 4;
                        setState(() {});
                      },
                      icon: (starIndex == 4 || starIndex == 5)
                          ? filledStar
                          : borderdStar,
                      color: mainColor,
                    ),
                    IconButton(
                      onPressed: () {
                        starIndex = 5;
                        setState(() {});
                      },
                      icon: starIndex == 5 ? filledStar : borderdStar,
                      color: mainColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: TextField(
                    controller: tfReviewController,
                    decoration: const InputDecoration(
                      hintText: '상품은 잘 받으셨나요? 판매자에게 후기를 남겨 주세요.',
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(),
                    ),
                    // obscureText: true,
                    maxLines: 20,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor)),
                  onPressed: () {
                    insertReview().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewListPage(
                              userId: toUserId,
                            ),
                          ),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('완료'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> insertReview() async {
    print("1. insert review");
    String reText = tfReviewController.text;
    int reStarRating = starIndex;
    String fromUserId1 = StaticUser.userId;

    var url = Uri.parse(
        "http://localhost:8080/review/write/$toUserId/$fromUserId1?to_userId=$toUserId&from_userId1=$fromUserId1&reText=$reText&reStarRating=$reStarRating");
    await http.get(url);

    await updateReliability();
    return true;
  }

  // 별점을 받은 유저의 reliability update
  Future<bool> updateReliability() async {
    int starRating = starIndex;
    int rowCount = await handler.selectRowCount(toUserId);
    int userReliability = await handler.selectReliability(toUserId);
    int updateReliability =
        ((userReliability * rowCount) + starRating * 10) ~/ (rowCount + 1);

    print("3. update reliability: $updateReliability");

    var url = Uri.parse(
        "http://localhost:8080/user/reliability/update/$toUserId?to_userId=$toUserId&userReliability=$updateReliability");
    await http.get(url);
    return true;
  }
}
