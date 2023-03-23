class ChatRoom {
  final String chatRoomId;
  final bool sendChatRoomState;
  final bool receiveChatRoomState;
  final String lastChat;
  final List userIds;
  final List userNames;
  final String receiveUserId;
  final String sendUserId;
  final int poId;

  ChatRoom({
    required this.chatRoomId,
    required this.sendChatRoomState,
    required this.receiveChatRoomState,
    required this.lastChat,
    required this.userIds,
    required this.userNames,
    required this.receiveUserId,
    required this.sendUserId,
    required this.poId,
  });
}
