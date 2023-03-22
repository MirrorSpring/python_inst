class Chat {
  final String chatId;
  final String chatText;
  final DateTime chatTime;
  final String sendUserId;
  final String photoUrl;

  Chat(
      {required this.chatId,
      required this.chatText,
      required this.chatTime,
      required this.sendUserId,
      required this.photoUrl});

  Chat.fromMap(Map<String, dynamic> res)
      : chatId = res['chatId'],
        chatText = res['chatText'],
        chatTime = res['chatTime'],
        sendUserId = res['sendUserId'],
        photoUrl = res['photoUrl'];
}
