import 'package:dl_flutter_app/View/wishlist.dart';
import 'package:dl_flutter_app/Widget/AppBar/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/User/static_user.dart';
import '../Model/User/user_mypage.dart';
import 'buylist.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late String userId;
  late UserModel model;
  late UserModel response;

  @override
  void initState() {
    super.initState();
    userId = 'zxc';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "마이 페이지: ${StaticUser.userName}",
          centerTitle: false,
          appBar: AppBar()),
      body: SafeArea(
        child: Column(
          children: [
            ExpansionTile(
              title: const Text('나의 프로필'),
              childrenPadding: const EdgeInsets.only(left: 60),
              children: [
                ListTile(
                  title: const Text('정보 수정'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    // 페이지 연결(수정은 병준님)
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('나의 거래'),
              childrenPadding: const EdgeInsets.only(left: 60),
              children: [
                ListTile(
                  title: const Text('찜목록'),
                  leading: const Icon(Icons.favorite_border),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WishList()));
                  },
                ),
                ListTile(
                  title: const Text('거래내역'),
                  leading: const Icon(Icons.monetization_on),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BuyList()));
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('기타'),
              childrenPadding: const EdgeInsets.only(left: 60),
              children: [
                ListTile(
                  title: const Text('로그아웃'),
                  leading: const Icon(Icons.arrow_back),
                  onTap: () {
                    // 로그인페이지 / 홈페이지
                    _showDialogLogOut(context);
                  },
                ),
                ListTile(
                  title: const Text('회원탈퇴'),
                  leading: const Icon(Icons.cancel),
                  onTap: () {
                    _userCheck(); // 회원 탈퇴 : 완전 삭제 아니고 딜리트데이트 추가
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _userCheck() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('정말 탈퇴하시겠습니까?'),
          content: const Text(
              '회원님이 올린 게시물, 댓글, 채팅이 전부 삭제되며, 다시 확인하거나 되돌릴 수 없습니다. 이에 동의하면 확인을 눌러주세요.'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _deleteUser();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext) =>
                                    MyPage()), // 향후 로그인 페이지로 수정
                            (route) => false);
                      },
                      child: const Text('확인')),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, '취소'),
                    child: Text('취소'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // 회원 탈퇴
  _deleteUser() async {
    model = UserModel();
    model.deleteUser(userId);
  }

  // 로그아웃
  _showDialogLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: const Text('정말 로그아웃 하시겠어요?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    '취소',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    '확인',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
