import 'dart:convert';
import 'package:http/http.dart' as http;

class Boarder {
  late List data = [];
  boardList(searchText) {
    data.clear();
    return boardList2(searchText);
  }

  // 게시글 목록 불러오기
  Stream<List> boardList2(searchText) async* {
    //searchText
    print("====함수====");
    print(searchText);
    if (searchText.length <= 2) {
      var url = await Uri.parse('http://localhost:8080/post/alljoin_upload');
      // return url
      var respnse = await http.get(url);
      var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
      data.addAll(dataConvertedJson);
      yield data;
    } else {
      var url = await Uri.parse(
          'http://localhost:8080/post/searchBoard?Search=$searchText');
      var respnse = await http.get(url);
      var dataConvertedJson = json.decode(utf8.decode(respnse.bodyBytes));
      data.addAll(dataConvertedJson);
      yield data;
    }
    // print("게시물목록 불러오기 성공");
  }
}
