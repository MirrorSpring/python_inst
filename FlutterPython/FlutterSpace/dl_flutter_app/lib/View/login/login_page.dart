import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:dl_flutter_app/Style/custom_colors.dart';
import 'package:dl_flutter_app/View/login/register_page.dart';
import 'package:dl_flutter_app/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widget/Login/my_button.dart';
import '../../Widget/Login/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Replay",
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(
                  height: 35,
                ),
                MyTextfield(
                  controller: emailController,
                  hintText: '이메일',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  controller: passwordController,
                  hintText: '비밀번호',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         '비밀번호를 분실하셨습니까?',
                //         style: TextStyle(color: Colors.grey[600]),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: '로그인',
                  onTap: signUserIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: CustomColors.pointColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//---function

  void signUserIn() async {
    //로딩화면
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // FirebaseAuth.instance.currentUser;
      // print(FirebaseAuth.instance.currentUser);
      selectUserInfo();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Tabbar();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      //로딩화면끄기
      Navigator.pop(context);
      // Wrong email
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  //function

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.pinkAccent,
          title: Center(
            child: Text(
              '계정정보가 일치하지 않습니다',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.pinkAccent,
          title: Center(
              child: Text(
            '계정정보가 일치하지 않습니다',
            style: TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  // 로그인한 user info static으로 저장
  // 존재 이유 의심 중
  selectUserInfo() async {
    String? uId = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection('user').doc(uId).get().then(
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          // print('데이터: ${documentSnapshot.data()}');
          print("data exist!");
          Map<String, dynamic>? data = documentSnapshot.data();

          StaticUser.userId = uId!;
          StaticUser.userName = data!['userName'];
          StaticUser.userAddress = data['userAddress'];
          StaticUser.userPw = data['userPw'];
          StaticUser.userReliability = data['userReliability'];
        } else {
          print('Document does not exist on the database');
        }
      },
    );
  }

  //-function
} //End
