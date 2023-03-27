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

class UpdateBorad extends StatefulWidget {
  const UpdateBorad(
      {super.key,
      required this.poId,
      required this.poTitle,
      required this.poContent,
      required this.poPrice,
      required this.poImage,
      required this.poInstrument});
  final int poId;
  final String poTitle;
  final String poContent;
  final String poPrice;
  final String poImage;
  final String poInstrument;

  @override
  State<UpdateBorad> createState() => _UpdateBoradState();
}

class _UpdateBoradState extends State<UpdateBorad> {
  late TextEditingController titleController =
      TextEditingController(text: widget.poTitle);
  late TextEditingController priceController =
      TextEditingController(text: widget.poPrice);
  late TextEditingController contentController =
      TextEditingController(text: widget.poContent);
  Alertclass gotocalss = Alertclass();
  late bool insertBoard = false;
  late String imagefile = "";
  final ImagePicker _picker = ImagePicker();

  File? _image;
  late Image cameraImage = Image.network(
    "http://localhost:8080/images/$poimage",
    fit: BoxFit.fill,
    width: MediaQuery.of(context).size.width * 1,
    height: MediaQuery.of(context).size.height * 0.4,
  );
  late String poimage = widget.poImage;
  late String dropdownValue = '악기목록';
  boarderTextStyle(Color? color) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  Snackbar snackbar = Snackbar();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.poInstrument;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          // (취소) -- 내 물건 팔기 --  [완료]
          Row(
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
                width: MediaQuery.of(context).size.width * 0.19,
              ),
              Text(
                "상품 등록 수정",
                style: boarderTextStyle(Colors.black),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.19,
              ),
              TextButton(
                onPressed: () {
                  /// 완료하면 인서트 해야 되는데
                  String name = titleController.text;
                  if (titleController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      contentController.text.isNotEmpty &&
                      poimage != "") {
                    insertBoard = true;
                    if (insertBoard == true) {
                      modifyBoard(
                          widget.poId,
                          titleController.text,
                          contentController.text,
                          priceController.text,
                          poimage);
                      pushHome();
                    }
                  } else {
                    insertBoard = false;
                  }
                  // snackbar 출력
                  insertBoard
                      ? snackbar.MySnackbar(context, "입력완료")
                      : snackbar.MySnackbar(context, "다시입력해주세요");

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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                TextField(
                  maxLength: 30,
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "글 제목"),
                ),
                // 가격
                TextField(
                    maxLength: 11,
                    controller: priceController,
                    decoration:
                        const InputDecoration(hintText: "가격 : 숫자만 입력가능"),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ]),
                // 내용 (힌트로 작성법 설명)
                TextField(
                  maxLength: 200,
                  maxLines: 6,
                  controller: contentController,
                  decoration: const InputDecoration(
                      hintText: "게시글 내용을 작성해주세요",
                      contentPadding: EdgeInsets.symmetric(vertical: 1)),
                ),
              ],
            ),
          )

          // 거래 희망장소 (편의점 선택) -> 폴리움 할 수 있게
          // 끝?
        ],
      ),
    );
  } ////

  // image
  Future<void> imageToServe() async {
    var selectImage = await _picker.getImage(
      maxWidth: 300,
      maxHeight: 250,
      source: ImageSource.gallery, //위치는 갤러리
    );
    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
      });
      upload(selectImage);
      dynamic sendData = selectImage.path;
      var formData =
          FormData.fromMap({'image': await MultipartFile.fromFile(sendData)});
      patchUserProfileImage(formData);
    }
  }

  // image
  Future<dynamic> patchUserProfileImage(dynamic input) async {
    var dio = new Dio();
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;
      var response = await dio.patch(
        'http://localhost:8080/src/main/resources/static/images/',
        data: input,
      );
      imagefile = response.data;
      return imagefile;
    } catch (e) {
      //
    }
  } //

  // TextField에 입력한 값을 받아와서 poTitle,poContent,poPrice,poImage01은 입력하고
  // 나머지는 기본값으로 준다. poUser의 경우는 나중에 로그인한 아이디로 처리하자.
  // post 테이블에 inset
  Future<int> modifyBoard(
      int Id, String title, String content, String price, String image) async {
    // var enginSizeCC = (engineSize + 1) * 1000;
    // poHeart,poTitle,poContent,poPrice,poImage01,poViews,poState,poUser
    int poId = Id;
    String poTitle = title;
    String poContent = content;
    String poPrice = price;
    String poImage01 = "";
    imagefile != "" ? poImage01 = imagefile : poImage01 = poimage;
    var url = Uri.parse(
        "http://localhost:8080/post/modify?poTitle=$poTitle&poContent=$poContent&poPrice=$poPrice&poImage01=$poImage01&poInstrument=$dropdownValue&poId=$poId");
    var response = await http.get(url);
    makemodifyDate(poId);
    return 0;
  }

  // Post에 insert했으면 그 PoId를 가져와야 한다.
  // 똑같이 입력한 값을 가지고 select 해서 ID 찾아서 Upload로 넘기자

  // uploadInsert
  Future<int> makemodifyDate(int id) async {
    // int poHeart = 0;
    int poId = id;
    String U_userId = StaticUser.userId;
    var url =
        Uri.parse("http://localhost:8080/post/modifyboard/$poId/$U_userId");
    var response = await http.get(url);
    return 0;
  }

  Future pushHome() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    gotocalss.gotoTapbar(context);
  }

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

// Future.delayed(Duration(seconds: 3));
} ///// END
