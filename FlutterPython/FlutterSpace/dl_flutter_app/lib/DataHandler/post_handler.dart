import 'dart:convert';
import 'package:http/http.dart' as http;

class PostHandler {
  Future<List> getPostDetail(int poId) async {
    var url = Uri.parse('http://localhost:8080/post/one/$poId');
    var response = await http.get(url);

    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON;
    // data.addAll(result);

    // print("result: ${result[0]['reText']}");

    // setState(() {});

    return result;
  }
}
