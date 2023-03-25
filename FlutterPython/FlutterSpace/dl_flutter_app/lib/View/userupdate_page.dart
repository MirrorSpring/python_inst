import 'package:dl_flutter_app/Model/User/static_user.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('아이디'),
                TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2))),
                ),
                Text('비밀번호'),
                TextField(
                  controller: userPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2))),
                ),
                Text('이름'),
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2))),
                ),
                Text('주소'),
                TextField(
                  controller: userAddressController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2))),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await updateUser(
                          userIdController.text.trim(),
                          userPasswordController.text.trim(),
                          userNameController.text.trim(),
                          userAddressController.text.trim());
                      userRefresh();
                    },
                    child: const Text('수정하기'))
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
