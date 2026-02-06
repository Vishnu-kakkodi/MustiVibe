class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String messageType;
  final String? text;
  final String? mediaUrl;
  final String status;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.messageType,
    this.text,
    this.mediaUrl,
    required this.status,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'],
      senderId: json['sender'] is Map
          ? json['sender']['_id']
          : json['sender'],
      receiverId: json['receiver'] is Map
          ? json['receiver']['_id']
          : json['receiver'],
      messageType: json['messageType'],
      text: json['text'],
      mediaUrl: json['mediaUrl'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sender': senderId,
      'receiver': receiverId,
      'messageType': messageType,
      'text': text,
      'mediaUrl': mediaUrl,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ✅ ADD THIS METHOD
  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? messageType,
    String? text,
    String? mediaUrl,
    String? status,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      messageType: messageType ?? this.messageType,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
