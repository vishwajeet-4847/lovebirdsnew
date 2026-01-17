class ChatMessageModel {
  final String chatTopicId;
  final String senderId;
  final String receiverId;
  final String message;
  final int messageType;
  final String date;
  final String senderRole;
  final String receiverRole;
  final String? messageId;

  ChatMessageModel({
    required this.chatTopicId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageType,
    required this.date,
    required this.senderRole,
    required this.receiverRole,
    this.messageId,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      chatTopicId: json['chatTopicId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      message: json['message'] ?? '',
      messageType: json['messageType'] ?? 1,
      date: json['date'] ?? '',
      senderRole: json['senderRole'] ?? '',
      receiverRole: json['receiverRole'] ?? '',
      messageId: json['messageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatTopicId': chatTopicId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'messageType': messageType,
      'date': date,
      'senderRole': senderRole,
      'receiverRole': receiverRole,
      'messageId': messageId,
    };
  }
}
