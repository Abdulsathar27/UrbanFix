class ReportModel {
  final String id;
  final String reporterId; 
  final String? reportedUserId; 
  final String? jobId;
  final String? chatId; 

  final String reason; 
  final String? description; 

  final String status; 


  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReportModel({
    required this.id,
    required this.reporterId,
    this.reportedUserId,
    this.jobId,
    this.chatId,
    required this.reason,
    this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

 
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'] ?? '',
      reporterId: json['reporterId'] ?? '',
      reportedUserId: json['reportedUserId'],
      jobId: json['jobId'],
      chatId: json['chatId'],
      reason: json['reason'] ?? '',
      description: json['description'],
      status: json['status'] ?? 'pending',
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
      'reporterId': reporterId,
      'reportedUserId': reportedUserId,
      'jobId': jobId,
      'chatId': chatId,
      'reason': reason,
      'description': description,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  
  ReportModel copyWith({
    String? id,
    String? reporterId,
    String? reportedUserId,
    String? jobId,
    String? chatId,
    String? reason,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReportModel(
      id: id ?? this.id,
      reporterId: reporterId ?? this.reporterId,
      reportedUserId:
          reportedUserId ?? this.reportedUserId,
      jobId: jobId ?? this.jobId,
      chatId: chatId ?? this.chatId,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
