class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String? receiverId;
  final String message;
  final String type; 
  final bool isSeen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.receiverId,
    required this.message,
    required this.type,
    required this.isSeen,
    this.createdAt,
    this.updatedAt,
  });

  
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id']?.toString() ?? '',
      chatId: json['chatId'] ?? '',
      senderId: json['sender']?.toString() ?? '',   
      receiverId: null,
      message: json['text'] ?? json['message'] ?? '', 
      type: 'text',
      isSeen: json['seen'] ?? json['isSeen'] ?? false, 
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'type': type,
      'isSeen': isSeen,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

 
  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    String? message,
    String? type,
    bool? isSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      type: type ?? this.type,
      isSeen: isSeen ?? this.isSeen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
