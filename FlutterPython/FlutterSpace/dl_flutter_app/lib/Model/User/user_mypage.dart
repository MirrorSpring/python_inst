import 'dart:convert';

import 'package:http/http.dart' as http;

class UserModel {
  // 회원 탈퇴
  Future deleteUser(String userId) async {
    var url = Uri.parse('http://localhost:8080/deleteUser/$userId');
    var response = await http.get(url);
  }

  // 회원 정보 가져오기
  Future<Map> userInfo(String userId) async {
    var url = Uri.parse('http://localhost:8080/userInfo?userId=$userId');
    // var url = Uri.parse('http://localhost:8080/user/all');
    var respnse = await http.get(url);
    var userInfo = json.decode(utf8.decode(respnse.bodyBytes));
    return userInfo[0];
  }

  // 회원 정보 수정
  Future updateUser(
      String userId, String userPw, String userName, String userAddress) async {
    var url = Uri.parse(
        'http://localhost:8080/updateUser/$userId/$userPw/$userName/$userAddress');
    var response = await http.get(url);
  }
}
