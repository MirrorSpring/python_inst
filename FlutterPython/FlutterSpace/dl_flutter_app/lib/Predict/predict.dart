import 'dart:convert';

import 'package:http/http.dart' as http;

class PredictImage {
  
    //이미지 올리기
  Future<String> upload(image) async {
    if (image != null) {
      var url = Uri.parse("http://localhost:5000/upload");
      var request = http.MultipartRequest("POST", url);
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));
      var response=await request.send();
      var dataConvertedJSON = json.decode(await response.stream.bytesToString());
      String result = dataConvertedJSON['result'];
      return result;
    }
    else{
      return 'error';
    }
  }
}