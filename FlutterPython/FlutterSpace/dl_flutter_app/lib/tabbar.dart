import 'package:dl_flutter_app/View/boardlist_page.dart';
import 'package:dl_flutter_app/View/my_page.dart';
import 'package:flutter/material.dart';

import 'View/chat/chatlist_page.dart';
import 'View/map_page.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  late int currentPageIndex;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          // NavigationDestination(
          //   icon: Icon(
          //     Icons.map,
          //   ),
          //   label: 'map',
          // ),
          NavigationDestination(
            icon: Icon(
              Icons.chat,
            ),
            label: 'chat',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
            ),
            label: 'Quiz',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        height: 44,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        elevation: 1,
      ),
      body: <Widget>[
        const BoardListPage(),
        // const MapPage(),
        const ChatListPage(),
        const MyPage(),
      ][currentPageIndex],
    );
  }
}
