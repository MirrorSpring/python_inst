import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:dl_flutter_app/View/my_page.dart';
import 'package:flutter/material.dart';

import '../Model/User/user_mypage.dart';

class UserUpdate extends StatefulWidget {
  const UserUpdate({super.key});

  @override
  State<UserUpdate> createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  late List userlist;
  late UserModel userhandler;
  late String userId;
  late TextEditingController userIdController;
  late TextEditingController userPasswordController;
  late TextEditingController userNameController;
  late TextEditingController userAddressController;

  var _isObscured; // 눈 아이콘 누르면 비밀번호 보이게 하기

  @override
  void initState() {
    super.initState();

    userhandler = UserModel();
    userlist = [];
    userId = StaticUser.userId;

    userIdController = TextEditingController();
    userPasswordController = TextEditingController();
    userNameController = TextEditingController();
    userAddressController = TextEditingController();

    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정보 수정'),
      ),
      body: FutureBuilder(
        future: userhandler.userInfo(userId),
        builder: (BuildContext context, AsyncSnapshot<Map> usersnapshot) {
          if (usersnapshot.hasData) {
            userIdController.text = usersnapshot.data!['userId'];
            userPasswordController.text = usersnapshot.data!['userPw'];
            userNameController.text = usersnapshot.data!['userName'];
            userAddressController.text = usersnapshot.data!['userAddress'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '아이디',
                  ),
                ),
                SizedBox(
                  width: 420.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: TextField(
                      readOnly: true,
                      controller: userIdController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2))),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('비밀번호'),
                ),
                SizedBox(
                  width: 420.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: TextField(
                      obscureText: _isObscured,
                      controller: userPasswordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.only(right: 12.0),
                            icon: _isObscured
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2))),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('이름'),
                ),
                SizedBox(
                  width: 420.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.badge_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2))),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('주소'),
                ),
                SizedBox(
                  width: 420.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: TextField(
                      controller: userAddressController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2))),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),
                          backgroundColor: Colors.orange),
                      onPressed: () async {
                        await updateUser(
                            userIdController.text.trim(),
                            userPasswordController.text.trim(),
                            userNameController.text.trim(),
                            userAddressController.text.trim());
                        // userRefresh();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('수정이 완료되었습니다.'),
                            actions: [
                              TextButton(
                                  // onPressed: () => Navigator.pop(context, 'OK'),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext) =>
                                                MyPage()),
                                        (route) => false);
                                  },
                                  child: Text('OK')),
                            ],
                          ),
                        );
                        // userRefresh();
                      },
                      child: const Text('수정하기'),
                    ),
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  // 회원 정보 수정
  updateUser(userId, userPw, userName, userAddress) {
    userhandler = UserModel();
    userhandler.updateUser(userId, userPw, userName, userAddress);
  }

  userRefresh() {
    setState(() {});
  }
}
