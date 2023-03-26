import 'package:dl_flutter_app/View/chat/chatroom_page.dart';
import 'package:flutter/material.dart';

import '../../DataHandler/review_handler.dart';
import '../../Model/Chat/static_chat.dart';
import '../../Model/User/static_user.dart';
import '../../Widget/AppBar/custom_app_bar.dart';

class ReviewListPage extends StatefulWidget {
  final String userId;

  const ReviewListPage({super.key, required this.userId});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  late List data;
  late ReviewHandler handler;
  late String toUserId;
  late String toUserName;
  final Color mainColor = const Color.fromARGB(255, 174, 195, 250);

  @override
  void initState() {
    super.initState();
    data = [];
    handler = ReviewHandler();
    toUserId = StaticChat.chatUserIds[0] == StaticUser.userId
        ? StaticChat.chatUserIds[1]
        : StaticChat.chatUserIds[0];
    toUserName = StaticChat.chatUserNames[0] == StaticUser.userName
        ? StaticChat.chatUserNames[1]
        : StaticChat.chatUserNames[0];
    handler.selectRowCount(toUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "$toUserName 상점 후기",
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const ChatRoomPage()),
                  ));
            },
            icon: const Icon(Icons.close),
            color: Colors.black,
          ),
        ],
        appBar: AppBar(),
      ),
      body: FutureBuilder(
        future: handler.getReivew(widget.userId),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return cardBuild(context, index, snapshot);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  //func -----
  Widget cardBuild(
      BuildContext context, int index, AsyncSnapshot<List> snapshot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: mainColor,
                    ),
                    Text(
                      ' ${snapshot.data![index]['reStarRating']}.0',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                snapshot.data![index]['from_userId1'] == StaticUser.userId
                    ? IconButton(
                        onPressed: () {
                          //
                          print(snapshot.data![index]['from_userId1']);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 17,
                          color: Colors.grey,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          //
                          print(snapshot.data![index]['from_userId1']);
                        },
                        icon: const Opacity(
                          opacity: 0,
                          child: Icon(
                            Icons.edit,
                            size: 17,
                            color: Colors.grey,
                          ),
                        ),
                      )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  snapshot.data![index]['reText'],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  snapshot.data![index]['reInDate'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
