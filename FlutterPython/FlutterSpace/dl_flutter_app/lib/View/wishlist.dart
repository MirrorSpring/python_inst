import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:dl_flutter_app/Model/mypage_list/list.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late ListModel handler;
  late String userId;
  late int poId;

  @override
  void initState() {
    super.initState();
    handler = ListModel();
    userId = StaticUser.userId; // 스태틱 변수(Id) 넣기
    poId = 1; // 스태틱 변수 넣기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찜 목록'),
      ),
      body: FutureBuilder(
        // future: handler.wishlistSelect(),
        future: handler.wishlistSelect(userId),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data == null) {
                return Text('no dataaaaaaaaaaaaaaa');
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
              ],
            ),
            trailing: const Icon(Icons.favorite, color: Colors.red),
            onTap: () async {
              await _deleteWish();
              refresh();
            },
          ),
          Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 16,
                color: Colors.black38,
              ),
              Text(snapshot.data[index]['poHeart'].toString()),
              snapshot.data[index]['poState'] == 0
                  ? Card(
                      elevation: 5,
                      child: Container(
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text('판매 중',
                            style: TextStyle(color: Colors.white, height: 1.0),
                            textAlign: TextAlign.center),
                      ),
                    )
                  : Card(
                      elevation: 10,
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text('판매 완료'),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  // 찜 목록 삭제
  _deleteWish() async {
    handler = ListModel();
    handler.deleteWish(userId, poId);
  }

  refresh() {
    setState(() {});
  }
}
