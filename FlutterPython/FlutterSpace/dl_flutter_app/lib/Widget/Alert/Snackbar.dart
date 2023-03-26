import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar {
  MySnackbar(BuildContext context, String message) {
    String TextMessage = message;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          TextMessage,
        ),
        duration: const Duration(
          seconds: 1,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
