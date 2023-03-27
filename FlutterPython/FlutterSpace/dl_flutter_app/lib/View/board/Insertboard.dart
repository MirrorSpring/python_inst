import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dl_flutter_app/Model/User/static_user.dart';
import 'package:dl_flutter_app/Widget/Alert/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../Widget/Alert/Snackbar.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  ScrollController scroller = ScrollController();
  late TextEditingController titleController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController contentController = TextEditingController();
  late TextEditingController val1 = TextEditingController();
  //
  late String searchText = "";
  //
  late String userId = "";
  late bool insertBoard = false;
  final ImagePicker _picker = ImagePicker();
  Alertclass gotocalss = Alertclass();
  late String imagefile = "";
  Snackbar snackbar = Snackbar();
  late Response _response;
  late String url = "";
  late Image cameraImage = Image.network(
      "http://localhost:8080/images/CameraImage.png",
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.4,
      fit: BoxFit.fill);
  //
  late Object formData = 0;
  // late String category = "카테고리를 선택하세요";
  File? _image;
  String dropdownValue = '악기목록';
  @override
  void initState() {
    super.initState();
    userId = StaticUser.userName;
  }

  boarderTextStyle(Color? color) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // gotoTapbar() {
  //   return Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Tabbar(),
  //       ),
  //       (route) => false);
  // }

  @override
  Widget build(BuildContext context) {
    // var response;
    return Scaffold(
      body: SingleChildScrollView(
        controller: scroller,
        physics: const AlwaysScrollableScrollPhysics(),
        // padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      gotocalss.gotoTapbar(context);
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                  ),
                  Text(
                    "판매 상품 등록",
                    style: boarderTextStyle(Colors.black),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                  ),
                  TextButton(
                    onPressed: () async {
                      /// 사진 이미지를 선택해라.
                      /// 사진 올리기를 하지 않았을경우 실행 X
                      await patchUserProfileImage(formData);
                      // 사진 이름을 imagefile에 저장
                      String name = titleController.text;

                      /// 제목, 가격, 내용, 사진이름을 모두 입력해야 통과
                      if (titleController.text.isNotEmpty &&
                          priceController.text.isNotEmpty &&
                          contentController.text.isNotEmpty &&
                          imagefile != "" &&
                          dropdownValue != "악기목록") {
                        insertBoard = true;
                        if (insertBoard == true) {
                          await makeBoard(
                              titleController.text,
                              contentController.text,
                              priceController.text,
                              imagefile);
                        }
                      } else {
                        insertBoard = false;
                      }
                      // snackbar 출력
                      insertBoard
                          ? snackbar.MySnackbar(context, "입력완료")
                          : snackbar.MySnackbar(context, "입력실패");

                      /// 1. 값 다 입력했는지 확인 및 정규화
                      /// 2. true 일 때만 입력해야 됨
                    },
                    child: Text(
                      "완료",
                      style: boarderTextStyle(Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // (취소) -- 내 물건 팔기 --  [완료]
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    _image == null
                        ? cameraImage
                        : Image.file(
                            _image!,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                  ],
                )),
            // 사진 올리는 버튼
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    imageToServe();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "사진 올리기 ",
                    style: boarderTextStyle(Colors.white),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("카테고리 : "),
                // String dropdownValue = 'One';
                // SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['악기목록', '어쿠스틱 기타', '일렉트릭 기타', '색소폰']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            // ===========
            // 글 제목
            TextField(
              maxLength: 30,
              controller: titleController,
              decoration: const InputDecoration(hintText: "글 제목"),
            ),
            // 가격
            TextField(
                maxLength: 11,
                controller: priceController,
                decoration: const InputDecoration(hintText: "가격 : 숫자만 입력가능"),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]),
            // 내용 (힌트로 작성법 설명)
            TextField(
              maxLength: 200,
              maxLines: 8,
              controller: contentController,
              decoration: const InputDecoration(
                  hintText: "게시글 내용을 작성해주세요",
                  contentPadding: EdgeInsets.symmetric(vertical: 2)),
            )

            // 거래 희망장소 (편의점 선택) -> 폴리움 할 수 있게
            // 끝?
          ],
        ),
      ),
    );
  } //// ===========================메소드=================================

  // TextField에 입력한 값을 받아와서 poTitle,poContent,poPrice,poImage01은 입력하고
  // 나머지는 기본값으로 준다. poUser의 경우는 나중에 로그인한 아이디로 처리하자.
  // post 테이블에 inset
  Future<int> makeBoard(
      String title, String content, String price, String image) async {
    int poHeart = 0;
    String poTitle = title;
    String poContent = content;
    String poPrice = price;
    String poImage01 = image;
    int poViews = 0;
    int poState = 0;
    String poUser = userId;

    var url = Uri.parse(
        "http://localhost:8080/post/insert?poHeart=$poHeart&poTitle=$poTitle" +
            "&poContent=$poContent&poPrice=$poPrice&poImage01=$poImage01&poInstrument=$dropdownValue&poViews=$poViews" +
            "&poState=$poState&poUser=$poUser");
    var response = await http.get(url);
    SelectpostId(poTitle, poContent, price, poImage01, poUser);
    return 0;
  }

  // Post에 insert했으면 그 PoId를 가져와야 한다.
  // 똑같이 입력한 값을 가지고 select 해서 ID 찾아서 Upload로 넘기자
  Future<int> SelectpostId(String title, String content, String price,
      String image, String poUsers) async {
    int poHeart = 0;
    String poTitle = title;
    String poContent = content;
    String poPrice = price;
    String poImage01 = image;
    int poViews = 0;
    int poState = 0;
    String poUser = poUsers;

    var url = Uri.parse(
        "http://localhost:8080/post/select/postId?poHeart=$poHeart&poTitle=$poTitle" +
            "&poContent=$poContent&poPrice=$poPrice&poImage01=$poImage01&poInstrument=$dropdownValue&poViews=$poViews" +
            "&poState=$poState&poUser=$poUser");
    var respnse = await http.get(url);
    var poId = json.decode(utf8.decode(respnse.bodyBytes));
    // upload insert로 넘김.
    makeUploadDate(poId, poUser);
    return poId;
  }

  // uploadInsert
  Future<int> makeUploadDate(int id, String poUser) async {
    // int poHeart = 0;
    await Future.delayed(const Duration(seconds: 4));
    int poId = id;
    String U_userId = StaticUser.userId;
    var url = Uri.parse("http://localhost:8080/post/views/$poId/$U_userId");
    await http.get(url);
    // ignore: use_build_context_synchronously
    gotocalss.gotoTapbar(context);
    return 0;
  }

  // image Server Upload1
  // 박태권 ==============
  // 2023.03.21
  Future<Object> imageToServe() async {
    var selectImage = await _picker.getImage(
      maxWidth: 300,
      maxHeight: 300,
      source: ImageSource.gallery, //위치는 갤러리
    );
    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
      });
      dynamic sendData = selectImage.path;
      formData =
          FormData.fromMap({'image': await MultipartFile.fromFile(sendData)});
      // patchUserProfileImage(formData);
      upload(selectImage);
      return formData;
    } else {
      return 0;
    }
  }

  // image server upload 2
  Future<dynamic> patchUserProfileImage(dynamic input) async {
    var dio = new Dio();
    if (input != 0) {
      try {
        dio.options.contentType = 'multipart/form-data';
        dio.options.maxRedirects.isFinite;
        var response = await dio.patch(
          'http://localhost:8080/src/main/resources/static/images/',
          data: input,
        );
        imagefile = response.data;
        imageslect(imagefile);
        return imagefile;
      } catch (e) {
        //
      }
    }
  } //

  // 카테고리 AI 사용 ******
  Future<String> upload(selectImage) async {
    if (selectImage != null) {
      var url = Uri.parse("http://localhost:5000/predict");
      var request = http.MultipartRequest("POST", url);
      request.files
          .add(await http.MultipartFile.fromPath('image', selectImage!.path));
      var response = await request.send();
      // print(json.decode(await response.stream.bytesToString()));
      var dataConvertedJSON =
          json.decode(await response.stream.bytesToString());
      String result = dataConvertedJSON['result'];
      setState(() {
        dropdownValue = result;
      });
      return result;
    } else {
      return 'error';
    }
  }

  Future imageslect(imagefile) async {
    // print(poId);
    String imagetext = imagefile;
    var url = await Uri.parse('http://localhost:8080/images/$imagetext');
    await http.get(url);
    setState(() {
      //
    });
    return url;
  }
} ///// END
