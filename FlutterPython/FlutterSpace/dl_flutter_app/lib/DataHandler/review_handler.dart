import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewHandler {
  Future<List> getReivew(String userId) async {
    var url = Uri.parse('http://localhost:8080/review/all/$userId');
    var response = await http.get(url);

    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON;
    // data.addAll(result);

    print("result: ${result[0]['reText']}");

    // setState(() {});

    return result;
  }

  // 여태껏 별점을 몇 명이 줬는지 세기
  // 평균을 내기 위해 필요합니다.
  Future<int> selectRowCount(String toUserId) async {
    var url = Uri.parse(
        "http://localhost:8080/review/count/$toUserId?to_userId=$toUserId");
    var response = await http.get(url);

    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    print("2. select row count: $dataConvertedJSON");
    return dataConvertedJSON;
  }

  // 별점을 받은 유저의 reliability select
  Future<int> selectReliability(String toUserId) async {
    var url = Uri.parse(
        "http://localhost:8080/user/reliability/$toUserId?to_userId=$toUserId");
    var response = await http.get(url);

    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    print("2. select reliability: $dataConvertedJSON");
    return dataConvertedJSON;
  }

  // 별점을 받은 유저의 reliability update
  // Future updateReliability(String toUserId) async {
  //   var url = Uri.parse(
  //       "http://localhost:8080/user/reliability/$toUserId?to_userId=$toUserId");
  //   var response = await http.get(url);

  //   var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
  //   print("2. select reliability: $dataConvertedJSON");
  //   return dataConvertedJSON;
  // }
}
