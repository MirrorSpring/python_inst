import 'package:http/http.dart' as http;

class UserModel {
  Future deleteUser(String userId) async {
    var url = Uri.parse('http://localhost:8080/deleteUser/$userId');
    var response = await http.get(url);
  }
}
