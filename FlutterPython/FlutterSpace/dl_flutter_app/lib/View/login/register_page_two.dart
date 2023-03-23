import 'package:dl_flutter_app/View/login/register_page_three.dart';
import 'package:flutter/material.dart';

import '../../Model/User/users.dart';
import '../../Widget/Login/my_textfield.dart';

class RegisterPageTwo extends StatefulWidget {
  final Function()? onTap;
  const RegisterPageTwo({super.key, this.onTap});

  @override
  State<RegisterPageTwo> createState() => _RegisterPageTwoState();
}

class _RegisterPageTwoState extends State<RegisterPageTwo> {
  late TextEditingController usernameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 25,
                // ),
                // const Icon(
                //   Icons.lock,
                //   size: 50,
                // ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  '프로필 설정',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  controller: usernameController,
                  hintText: '닉네임(가게명)을 입력해주세요',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // MyTextfield(
                //   controller: useraddressController,
                //   hintText: '주소를 입력해주세요',
                //   obscureText: false,
                // ),

                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              '이전',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 160,
                      child: GestureDetector(
                        onTap: () {
                          uploadUserName();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPageThree();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 110, 173, 143),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              '다음(건너뛰기)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//function ---------------------------------
  void uploadUserName() {
    UserModel2.userName = usernameController.text.trim();
  }
}//End
