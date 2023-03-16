class ChatRoom {
  final String chatRoomId;
  final bool chatRoomState;
  final String lastChat;
  final List userIds;
  final List userNames;

  ChatRoom({
    required this.chatRoomId,
    required this.chatRoomState,
    required this.lastChat,
    required this.userIds,
    required this.userNames,
  });
}
