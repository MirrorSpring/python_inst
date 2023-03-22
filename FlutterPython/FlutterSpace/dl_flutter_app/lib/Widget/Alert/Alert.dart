import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../tabbar.dart';
// import '../widgets/custom_style.dart';

class Alertclass {
  Alert(BuildContext context, int P_poId) {
    // CustomStyle textcolor = CustomStyle();
    // setState(() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(
              '경고!',
              style: TextStyle(color: Colors.red),
            ),
            content: SizedBox(
              width: 200,
              child: Row(
                children: const [
                  // Icon(Icons.),
                  Text(' 정말로 삭제하시겠습니까?'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  deldatepost(P_poId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Tabbar()),
                    ),
                  );
                },
                child: const Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('아니요'),
              ),
            ],
          );
        });
    // });
  } //

  Future deldatepost(P_poId) async {
    var url = await Uri.parse('http://localhost:8080/post/deldate/$P_poId');
    await http.get(url);
    // print(url);
    return;
  }
}//
