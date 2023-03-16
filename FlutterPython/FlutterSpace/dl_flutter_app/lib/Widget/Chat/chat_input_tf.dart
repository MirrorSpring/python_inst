import 'package:flutter/material.dart';

class ChatInputTf extends StatelessWidget {
  final TextEditingController tfChatController;

  const ChatInputTf({super.key, required this.tfChatController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 204, 204, 204),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        // ------------------------------------------------- 채팅 tf
        child: TextField(
          controller: tfChatController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
