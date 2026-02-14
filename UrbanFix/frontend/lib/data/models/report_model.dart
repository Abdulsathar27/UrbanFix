class ReportModel {
  final String id;
  final String reporterId; // User who created the report
  final String? reportedUserId; // Optional: if reporting a user
  final String? jobId; // Optional: if reporting a job
  final String? chatId; // Optional: if reporting a chat/message

  final String reason; // spam, abuse, fake job, etc.
  final String? description; // additional explanation

  final String status; 
  // pending, reviewed, resolved, rejected

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

  // ==========================
  // From JSON
  // ==========================
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

  // ==========================
  // To JSON
  // ==========================
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

  // ==========================
  // Copy With
  // ==========================
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
