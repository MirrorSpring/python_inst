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

  // static getReview() {}
}
