import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/User/static_user.dart';
import '../Model/User/users.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print("static user id: ${StaticUser.userId}");
    print("static user name: ${StaticUser.userName}");
    print("auth id: ${FirebaseAuth.instance.currentUser?.uid}");
    // print("auth: ${FirebaseAuth.instance.currentUser}");
    // print("auth: ${FirebaseAuth.instance.currentUser?.uid}");
    // print("auth: ${FirebaseAuth.instance.currentUser?.uid}");
  }

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
} // END
