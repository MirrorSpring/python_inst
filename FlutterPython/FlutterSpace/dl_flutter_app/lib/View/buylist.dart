import 'package:dl_flutter_app/Model/mypage_list/list.dart';
import 'package:flutter/material.dart';

class BuyList extends StatefulWidget {
  const BuyList({super.key});

  @override
  State<BuyList> createState() => _BuyListState();
}

class _BuyListState extends State<BuyList> {
  late ListModel handler;
  late String userId;
  late int postId;

  @override
  void initState() {
    super.initState();
    handler = ListModel();
    userId = 'abc'; // 스태틱 변수(Id) 넣기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매 내역'),
      ),
      body: FutureBuilder(
        future: handler.buylistSelect(userId),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data == null) {
                return Text('no dataaaaaaaaa');
              } else {
                return cardBuild(context, index, snapshot);
              }
            },
          );
        },
      ),
    );
  }

  Widget cardBuild(BuildContext context, int index, AsyncSnapshot snapshot) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Text(snapshot.data[index]['poImage'].toString()),
            title: Text(snapshot.data[index]['poTitle'].toString()),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(snapshot.data[index]['poPrice'].toString()),
                Text(snapshot.data[index]['poState'].toString())
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 13,
                color: Colors.black38,
              ),
              Text(snapshot.data[index]['poHeart'].toString()),
            ],
          ),
        ],
      ),
    );
  }
}
