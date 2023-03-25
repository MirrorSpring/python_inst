import 'package:http/http.dart' as http;

class PredictImage {
  
    //이미지 올리기
  Future<void> upload(image) async {
    if (image != null) {
      var url = Uri.parse("http://localhost:5000/upload");
      var request = http.MultipartRequest("POST", url);
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));
      await request.send();
    }
  }
}