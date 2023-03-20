import 'package:dl_flutter_app/Widget/AppBar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'board/homeboard.dart';

class BoardListPage extends StatefulWidget {
  const BoardListPage({super.key});

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "게시물", centerTitle: false, appBar: AppBar()),
      body: Homeboard(),
    );
  }
}
