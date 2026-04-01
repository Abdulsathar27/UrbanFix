class ChatModel {
  final String id;              
  final String chatStringId;   
  final List<String> participantIds;
  final Map<String, String> participantNames; 
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChatModel({
    required this.id,
    required this.chatStringId,
    required this.participantIds,
    this.participantNames = const {},
    this.lastMessage,
    this.lastMessageTime,
    required this.unreadCount,
    this.createdAt,
    this.updatedAt,
  });

  
  factory ChatModel.fromStringId(String chatStringId) {
    return ChatModel(
      id: '',
      chatStringId: chatStringId,
      participantIds: chatStringId.split('_'),
      unreadCount: 0,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
   
    final membersList = json['members'] as List? ?? [];
    final participantIds = <String>[];
    final participantNames = <String, String>{};

    for (final member in membersList) {
      if (member is Map<String, dynamic>) {
        final memberId = member['_id']?.toString() ?? '';
        final memberName = member['name']?.toString() ?? '';
        if (memberId.isNotEmpty) {
          participantIds.add(memberId);
          if (memberName.isNotEmpty) participantNames[memberId] = memberName;
        }
      } else {
        final id = member.toString();
        if (id.isNotEmpty) participantIds.add(id);
      }
    }

    
    String? lastMessageText;
    DateTime? lastMessageTime;
    final lm = json['lastMessage'];
    if (lm is Map<String, dynamic>) {
      lastMessageText = lm['text']?.toString();
      if (lm['createdAt'] != null) {
        lastMessageTime = DateTime.tryParse(lm['createdAt'].toString());
      }
    } else if (lm is String) {
      lastMessageText = lm;
    }

    return ChatModel(
      id: json['_id']?.toString() ?? '',
      chatStringId: json['chatId'] ?? '',
      participantIds: participantIds,
      participantNames: participantNames,
      lastMessage: lastMessageText,
      lastMessageTime: lastMessageTime,
      unreadCount: 0,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chatId': chatStringId,
      'members': participantIds,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime?.toIso8601String(),
      'unreadCount': unreadCount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  ChatModel copyWith({
    String? id,
    String? chatStringId,
    List<String>? participantIds,
    Map<String, String>? participantNames,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      chatStringId: chatStringId ?? this.chatStringId,
      participantIds: participantIds ?? this.participantIds,
      participantNames: participantNames ?? this.participantNames,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
