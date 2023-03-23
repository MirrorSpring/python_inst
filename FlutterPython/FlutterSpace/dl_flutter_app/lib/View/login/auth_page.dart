import 'package:dl_flutter_app/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_pages.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //로그인한경우
          if (snapshot.hasData) {
            return HomePage();
          }
          //로그인하지 않은 경우
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
