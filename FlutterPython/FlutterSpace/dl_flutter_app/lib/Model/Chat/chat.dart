class Chat {
  final String chatId;
  final String chatText;
  final DateTime chatTime;
  // final List userIds;
  final String sendUserId;

  Chat({
    required this.chatId,
    required this.chatText,
    required this.chatTime,
    // required this.userIds,
    required this.sendUserId,
  });

  Chat.fromMap(Map<String, dynamic> res)
      : chatId = res['chatId'],
        chatText = res['chatText'],
        chatTime = res['chatTime'],
        // userIds = res['userIds'];
        sendUserId = res['sendUserId'];
}
