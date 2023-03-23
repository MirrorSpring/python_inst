import 'package:flutter/material.dart';

import 'chat/chatlist_page.dart';
import 'chat/userlist_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatListPage(),
                  ),
                );
              },
              child: const Text('채팅 목록'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserList(),
                  ),
                );
              },
              child: const Text('유저 목록'),
            ),
          ],
        ),
      ),
    );
  }
}
