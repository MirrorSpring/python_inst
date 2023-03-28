import 'package:dl_flutter_app/Model/mypage_list/list.dart';
import 'package:flutter/material.dart';

import '../Model/User/static_user.dart';

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
    userId = StaticUser.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매 내역', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 243, 242, 239),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        // future: handler.wishlistSelect(),
        future: handler.buylistSelect(userId),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  '판매한 목록이 없습니다.',
                  style: TextStyle(fontSize: 25, color: Colors.black26),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return buyBuild(context, index, snapshot);
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget buyBuild(BuildContext context, int index, AsyncSnapshot snapshot) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 82,
                        child: Image.network(
                            "http://localhost:8080/images/${snapshot.data[index]['poImage01']}"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          snapshot.data[index]['poTitle'].toString(),
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        snapshot.data[index]['poPrice'].toString(),
                        style: const TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      snapshot.data[index]['poState'] == 0
                          ? const SizedBox(
                              width: 65,
                              height: 35,
                              child: Card(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    '판매 완료',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              width: 65,
                              height: 35,
                              child: Card(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    '판매 중',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.black38,
                  ),
                  Text(
                    snapshot.data[index]['poHeart'].toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
