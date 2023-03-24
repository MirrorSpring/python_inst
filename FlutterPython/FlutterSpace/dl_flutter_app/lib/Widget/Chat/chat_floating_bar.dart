import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../DataHandler/post_handler.dart';

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
  late PostHandler handler;

  @override
  void initState() {
    super.initState();
    handler = PostHandler();
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
                            // 천단위 쉼표를 위해 number format
                            Text(
                                '${NumberFormat('###,###,###,###').format(int.parse(snapshot.data![0]['poPrice'])).replaceAll(' ', '')}원'),
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0) // POINT
                                      ),
                                  color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(snapshot.data![0]['poState'] == 0
                                    ? "판매중"
                                    : "거래완료"),
                              ),
                            ),
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
