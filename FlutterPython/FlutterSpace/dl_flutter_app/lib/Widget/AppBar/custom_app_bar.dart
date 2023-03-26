import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final AppBar appBar;
  final List<Widget>? actions;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.centerTitle,
      required this.appBar,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: centerTitle,
      elevation: 1,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height * 0.8);
}
