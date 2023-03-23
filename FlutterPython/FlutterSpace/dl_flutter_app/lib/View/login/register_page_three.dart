import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/Gu/gu_list.dart';
import '../../Model/User/users.dart';

class RegisterPageThree extends StatefulWidget {
  final Function()? onTap;
  const RegisterPageThree({super.key, this.onTap});

  @override
  State<RegisterPageThree> createState() => _RegisterPageThreeState();
}

class _RegisterPageThreeState extends State<RegisterPageThree> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController useraddressController;
  late TextEditingController usernameController;
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
  late List<String> guList;

  late String userId;
  late String userPw;
  late String userName;
  late String userAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    usernameController = TextEditingController();
    useraddressController = TextEditingController();
    guList = GuList.guList;
    userId = '';
    userPw = '';
    userName = '';
    userAddress = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                '내 동네 설정',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _runSearch();
                    });
                  },
                  controller: useraddressController,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
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
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: '내 동네 이름(동,읍,면)으로 검색',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //현재 위치로 찾기 버튼 --------------------------
              GestureDetector(
                onTap: () {
                  fetchAdministrativeDistrict();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 110, 173, 143),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      '현재 위치로 찾기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // -----------------------------------------------------------
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 450,
                child: ListView.builder(
                  itemCount: guList.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        useraddressController.text =
                            guList[position].substring(3);
                      },
                      child: ListTile(
                        title: Text(guList[position],
                            style: const TextStyle(fontSize: 18.0)),
                      ),
                    );
                  },
                ),
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
                        signUserUp();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 110, 173, 143),
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

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

//---function

  void signUserUp() async {
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
    try {
      //비밀번호와 비밀번호 확인이 같은지 체크

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: UserModel2.userId, password: UserModel2.userPw);

      //첫화면까지 모든 창을 pop하는 코드
      Navigator.popUntil(context, (route) => route.isFirst);

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
      }
    }

    // Mysql에 User 정보 넣는 부분 -------------
    userId = UserModel2.userId;
    userPw = UserModel2.userPw;
    // defalut 는 강남구
    userAddress = useraddressController.text.isNotEmpty
        ? useraddressController.text
        : '강남구';
    //default는 손님32
    userName = UserModel2.userName.isEmpty ? '손님32' : UserModel2.userName;

    //print로 4가지정보 잘전달되는지 확인
    print('==========회원정보=======');
    print(userId);
    print(userPw);
    print(userName);
    print(userAddress);
    print('======회원정보=======');
    insertUser();
  }

  //function

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color.fromARGB(255, 79, 79, 79)),
            ),
          ),
        );
      },
    );
  }

// MySql 에 넣는 메소드 ------------------(미완성)
  // getJSONData() async {
  //   var url = Uri.parse(
  //       'http://localhost:8080/DLFlutter/user_insert.jsp?userId=$userId&userPw=$userPw&userAddress=$userAddress&userName=$userName');
  //   await http.get(url);
  // }

  Future<bool> insertUser() async {
    print("1. insert review");
    // String userId = userId;
    // String userPw = userPw;
    // String fromUserId1 = StaticUser.userId;

    var url = Uri.parse(
        'http://localhost:8080/user/insert/$userId?userId=$userId&userPw=$userPw&userAddress=$userAddress&userName=$userName');
    await http.get(url);

    // await updateReliability();
    return true;
  }

// 위도경도에 따른 행정구명 받는 메소드
  Future<List> fetchAdministrativeDistrict() async {
    final response = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=127.047325&y=37.517236'),
        headers: {'Authorization': 'KakaoAK b3b0f68cd5fc7249fca890e1465fa4fe'});

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<dynamic> codes =
          result['documents'][0]['region_2depth_name'].split(' ');
      print(codes);
      useraddressController.text = codes[0];
      return codes.map((e) => e.trim()).toList();
      // print(codes);
      // return codes;
    } else {
      print('error');
      throw Exception('Failed to load district');
    }
  }

  //검색 메소드 ----------------------------------------------------
  Future<List> _runSearch() async {
    guList = GuList.guList
        .where(
            (district) => district.contains(useraddressController.text.trim()))
        .toList();
    return guList;
  }
}//End
