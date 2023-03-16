import 'package:flutter/material.dart';

import '../../View/review_page.dart';

class ChatFloatingBar extends StatelessWidget {
  final String userId;

  const ChatFloatingBar({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 235, 235, 235),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                    'https://www.logmall.com/shopimages/logmall/054005000054.jpg?1645081351'),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('20,000원'),
                    Text('기타'),
                    Text('판매중'),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9AB6FF), // Background color
                ),
                onPressed: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        userId: userId,
                      ),
                    ),
                  );
                },
                child: const Text(
                  '거래 완료',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
