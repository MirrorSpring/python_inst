import 'package:dl_flutter_app/DataHandler/post_handler.dart';
import 'package:dl_flutter_app/Model/board/post_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../View/review/review_page.dart';

class ChatFloatingBar extends StatefulWidget {
  final String userId;
  final int poId;

  const ChatFloatingBar({
    super.key,
    required this.userId,
    required this.poId,
  });

  @override
  State<ChatFloatingBar> createState() => _ChatFloatingBarState();
}

class _ChatFloatingBarState extends State<ChatFloatingBar> {
  // late List result;
  late PostHandler handler;

  @override
  void initState() {
    super.initState();
    // result = [];
    handler = PostHandler();
    // getPostDetail(widget.poId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.getPostDetail(widget.poId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                            'http://localhost:8080/images/${snapshot.data![0]['poImage01']}'),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${snapshot.data![0]['poTitle']}'),
                            Text('${snapshot.data![0]['poPrice']}원'),
                            Text(snapshot.data![0]['poState'] == 0
                                ? "판매중"
                                : "거래완료"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
