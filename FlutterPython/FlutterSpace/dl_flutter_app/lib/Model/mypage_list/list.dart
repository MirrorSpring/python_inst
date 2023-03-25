import 'dart:convert';
import 'package:http/http.dart' as http;

class ListModel {
// 찜 목록
  Future<List> wishlistSelect(String userId) async {
    var url = Uri.parse('http://localhost:8080/wishlistSelect?userId=$userId');
    var respnse = await http.get(url);
    var wishlistResult = json.decode(utf8.decode(respnse.bodyBytes));
    return wishlistResult;
  }

// 찜 목록 지우기
  Future deleteWish(String userId, int poId) async {
    var url = Uri.parse('http://localhost:8080/deleteWish/$userId/$poId');
    var response = await http.get(url);
  }

// 판매 내역
  Future<List> buylistSelect(String userId) async {
    var url = Uri.parse('http://localhost:8080/buylistSelect?userId=$userId');
    var respnse = await http.get(url);
    var buylistResult = json.decode(utf8.decode(respnse.bodyBytes));
    return buylistResult;
  }

  // 찜 목록 삭제시 하트 수 -1
  Future wishDownpoHeart(int poId) async {
    var url = Uri.parse('http://localhost:8080/wishdown/$poId');
    var response = await http.get(url);
  }
}
