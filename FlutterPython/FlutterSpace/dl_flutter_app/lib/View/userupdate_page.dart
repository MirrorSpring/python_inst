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
        title: const Text('정보 수정', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 243, 242, 239),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 12.0),
                            icon: _isObscured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(197, 173, 231, 216),
                                width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(197, 173, 231, 216),
                                  width: 2))),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(197, 173, 231, 216),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(197, 173, 231, 216),
                                  width: 2))),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(197, 173, 231, 216),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(197, 173, 231, 216),
                                  width: 2))),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50),
                          backgroundColor: const Color(0xffFEC260)),
                      onPressed: () async {
                        await updateUser(
                            userIdController.text.trim(),
                            userPasswordController.text.trim(),
                            userNameController.text.trim(),
                            userAddressController.text.trim());
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('수정이 완료되었습니다.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext) =>
                                                MyPage()),
                                        (route) => false);
                                  },
                                  child: const Text('OK')),
                            ],
                          ),
                        );
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
}
