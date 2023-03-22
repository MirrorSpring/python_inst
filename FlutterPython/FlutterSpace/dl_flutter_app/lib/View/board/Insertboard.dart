import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dl_flutter_app/View/board/homeboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../Widget/Alert/Snackbar.dart';
import '../boardlist_page.dart';

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
  late bool insertBoard = false;
  final ImagePicker _picker = ImagePicker();
  late String imagefile = "";
  Snackbar snackbar = Snackbar();
  late Response _response;
  late String url = "";
  late Image cameraImage;
  File? _image;
  @override
  void initState() {
    super.initState();
    cameraImage = Image.network("http://localhost:8080/images/CameraImage.png");
  }

  boarderTextStyle(Color? color) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  Widget build(BuildContext context) {
    // var response;
    return Scaffold(
      body: SingleChildScrollView(
        controller: scroller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // (취소) -- 내 물건 팔기 --  [완료]
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // 취소가 되야 돼
                    // 팝으로 넘어가는데 게시판 상태가 갱신이 안됨,
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 75,
                ),
                Text(
                  "판매 상품 등록",
                  style: boarderTextStyle(Colors.black),
                ),
                const SizedBox(
                  width: 75,
                ),
                TextButton(
                  onPressed: () async {
                    /// 완료하면 인서트 해야 되는데
                    String name = titleController.text;
                    if (titleController.text.isNotEmpty &&
                        priceController.text.isNotEmpty &&
                        contentController.text.isNotEmpty &&
                        imagefile != "") {
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
            Container(
                color: Colors.white,
                width: 250,
                height: 240,
                child: Column(
                  children: [
                    _image == null ? cameraImage : Image.file(_image!),
                  ],
                )),
            // 사진 올리는 버튼
            SizedBox(
              width: 300,
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
              maxLength: 400,
              maxLines: 10,
              controller: contentController,
              decoration: const InputDecoration(
                  hintText: "게시글 내용을 작성해주세요",
                  contentPadding: EdgeInsets.symmetric(vertical: 20)),
            )

            // 거래 희망장소 (편의점 선택) -> 폴리움 할 수 있게
            // 끝?
          ],
        ),
      ),
    );
  } ////

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
    String poUser = "kimdo";

    var url = Uri.parse(
        "http://localhost:8080/post/insert?poHeart=$poHeart&poTitle=$poTitle" +
            "&poContent=$poContent&poPrice=$poPrice&poImage01=$poImage01&poViews=$poViews" +
            "&poState=$poState&poUser=$poUser");
    var response = await http.get(url);
    SelectpostId(poTitle, poContent, price, poImage01);
    return 0;
  }

  // Post에 insert했으면 그 PoId를 가져와야 한다.
  // 똑같이 입력한 값을 가지고 select 해서 ID 찾아서 Upload로 넘기자
  Future<int> SelectpostId(
      String title, String content, String price, String image) async {
    int poHeart = 0;
    String poTitle = title;
    String poContent = content;
    String poPrice = price;
    String poImage01 = image;
    int poViews = 0;
    int poState = 0;
    String poUser = "kimdo";

    var url = Uri.parse(
        "http://localhost:8080/post/select/postId?poHeart=$poHeart&poTitle=$poTitle" +
            "&poContent=$poContent&poPrice=$poPrice&poImage01=$poImage01&poViews=$poViews" +
            "&poState=$poState&poUser=$poUser");
    var respnse = await http.get(url);
    var poId = json.decode(utf8.decode(respnse.bodyBytes));
    // upload insert로 넘김.
    makeUploadDate(poId);
    return poId;
  }

  // uploadInsert
  Future<int> makeUploadDate(int id) async {
    // int poHeart = 0;
    int poId = id;
    String U_userId = "korea";
    var url = Uri.parse("http://localhost:8080/post/views/$poId/$U_userId");
    await http.get(url);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const BoardListPage()),
      ),
    );
    return 0;
  }

  // image
  Future<void> imageToServe() async {
    final XFile? selectImage = await _picker.pickImage(
      source: ImageSource.gallery, //위치는 갤러리
    );
    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
      });
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
      imageslect(imagefile);
      return imagefile;
    } catch (e) {}
  } //

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
