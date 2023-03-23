import 'package:dl_flutter_app/View/login/register_page_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../Model/User/users.dart';
import '../../Widget/Login/my_textfield_valid.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController useraddressController;
  late TextEditingController usernameController;
  late String alertMessage;
  late Icon? checkIcon;
  bool _emailCheck = false;
  bool _emailCheck2 = true;
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    usernameController = TextEditingController();
    useraddressController = TextEditingController();
    alertMessage = "";
    _focusNode.addListener(_onFocusChanged);
    checkIcon = null;
  }

  @override
  void dispose() {
    // FocusNode 이벤트 리스너 제거
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();

    super.dispose();
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
                  '지금 아이디를 만들어보세요!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // ValidTextfield(
                //   controller: emailController,
                //   hintText: '이메일',
                //   obscureText: false,
                //   formKey: formKey1,
                //   warningText: '이메일 형식에 맞게 입력해주세요',
                //   regexValid: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: formKey1,
                    child: TextFormField(
                      focusNode: _focusNode,
                      controller: emailController,
                      obscureText: false,
                      onChanged: ((value) {
                        formKey1.currentState?.validate();
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            _emailCheck2 = false;
                          });
                          return "이메일을 입력해주세요";
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          setState(() {
                            _emailCheck2 = false;
                          });
                          return '이메일 형식에 맞게 입력해주세요';
                        } else {
                          _emailCheck2 = true;
                          return null;
                        }
                        // return null;
                      },
                      onEditingComplete: () {
                        isEmailAlreadyInUse(emailController.text.trim());
                      },
                      decoration: InputDecoration(
                          suffixIcon: _emailCheck && _emailCheck2
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                          //선택 비선택시 테두리색깔
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 110, 173, 143),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: '이메일',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //password textfield
                ValidTextfield(
                  controller: passwordController,
                  hintText: '비밀번호',
                  obscureText: true,
                  formKey: formKey2,
                  warningText: '비밀번호 형식에 맞게 입력해주세요',
                  regexValid: r'^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        '영문, 숫자 조합으로 8-20자리 입력해주세요',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: formKey3,
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      onChanged: ((value) {
                        formKey3.currentState?.validate();
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "비밀번호 확인란을 입력해주세요";
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return '비밀번호가 일치하지 않습니다.';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          //선택 비선택시 테두리색깔
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 110, 173, 143),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: '비밀번호 확인',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                    ),
                  ),
                ),
                // 비밀번화 확인 일치불일치 메시지뜨는곳
                Text(
                  alertMessage,
                  style: TextStyle(color: Colors.blue),
                ),
                //confirm password textfield
                // MyTextfield(
                //   controller: confirmPasswordController,
                //   hintText: '비밀번호 확인',
                //   obscureText: true,
                // ),

                const SizedBox(
                  height: 10,
                ),

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
                          // nextPage();
                          signUp();
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
                              '다음',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // 카톡, 구글 로그인부분 -----------------------------------
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     SquareTile(imagePath: 'images/googlelogo.png'),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     SquareTile(imagePath: 'images/kakao.png')
                //   ],
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // -----------------------------------------------------
                //이미계정을 가지고있습니까?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '이미 계정을 가지고 있습니까?',
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
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        '로그인 하러가기',
                        style: TextStyle(
                          color: Colors.blue,
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
  void nextPage() {
    if (passwordController.text == confirmPasswordController.text) {
      UserModel2.userId = emailController.text;
      UserModel2.userPw = passwordController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const RegisterPageTwo();
          },
        ),
      );
    } else {
      showErrorMessage('입력란을 확인해 주세요');
    }
  }

  //function

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 55, 55),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        );
      },
    );
  }

  getJSONData() async {
    var userId = emailController.text;
    var userPw = passwordController.text;
    var userAddress = useraddressController.text;
    var userName = usernameController.text;

    var url = Uri.parse(
        'http://localhost:8080/DLFlutter/user_insert.jsp?userId=$userId&userPw=$userPw&userAddress=$userAddress&userName=$userName');
    await http.get(url);
    // _showDialog(context);
  }

  void signUp() async {
    //로딩화면
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
    //유저생성
    // BuildContext context = this.context;
    try {
      //비밀번호와 비밀번호 확인이 같은지 체크
      if (emailController.text.trim().isEmpty) {
        showErrorMessage('이메일을 입력해주세요');
      } else if (passwordController.text.trim().isEmpty) {
        showErrorMessage('비밀번호를 입력해주세요');
      } else if (confirmPasswordController.text.trim().isEmpty) {
        showErrorMessage('비밀번호확인란을 입력해주세요');
      } else if (passwordController.text == confirmPasswordController.text) {
        UserModel2.userId = emailController.text;
        UserModel2.userPw = passwordController.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const RegisterPageTwo();
            },
          ),
        );
      } else {
        //에러메시지
        showErrorMessage('입력란을 확인해주세요!');
      }

      // pop the loading circle
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
//로딩화면끄기
      Navigator.pop(context);
      // Wrong email
      if (e.code == 'user-not-found') {
        //없는계정
        showErrorMessage('계정정보가 일치하지 않습니다');
      } else if (e.code == 'wrong-password') {
        //비밀번호 틀림
        showErrorMessage('계정정보가 일치하지 않습니다');
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage('이미 가입한 이메일 입니다');
      }
    }
  }

  // // 이메일 중복확인 메소드
  // Future<bool> checkDuplicate(String name) async {
  //   final collection = FirebaseFirestore.instance.collection('users');
  //   final querySnapshot = await collection.where('name', isEqualTo: name).get();
  //   final exists = querySnapshot.docs.isNotEmpty;
  //   return exists;
  // }
  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      print(signInMethods.isNotEmpty);
      setState(() {
        if (signInMethods.isNotEmpty) {
          _emailCheck = false;
        } else {
          _emailCheck = true;
        }
      });
      return signInMethods.isNotEmpty;
    } catch (e) {
      print('이메일 중복 체크 중 오류 발생: $e');
      return true; // 중복 체크 실패 시 중복으로 간주
    }
  }

// 클릭이 풀렸는지 확인하는 메소드
  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      // TextField 클릭됨
      print('TextField 클릭됨');
    } else {
      // TextField 클릭이 풀림
      isEmailAlreadyInUse(emailController.text.trim());
      print('TextField 클릭이 풀림');
    }
  }
} //End