class AppointmentModel {
  final String id;
  final String userId;      // customer id
  final String workerId;    // service provider id
  final String jobId;
  final String workTitle;   // service name
  final String? description;
  final String date;        // "YYYY-MM-DD"
  final String? time;       // "09:00 AM"
  final double requestedWage;
  final String status;
  final String? cancelReason;
  final String? rejectReason;
  final DateTime? cancelledAt;
  final DateTime? rejectedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional: populated user/worker details (for display)
  final Map<String, dynamic>? userDetails;
  final Map<String, dynamic>? workerDetails;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.workerId,
    required this.jobId,
    required this.workTitle,
    this.description,
    required this.date,
    this.time,
    required this.requestedWage,
    required this.status,
    this.cancelReason,
    this.rejectReason,
    this.cancelledAt,
    this.rejectedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.userDetails,
    this.workerDetails,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    // Handle populated fields (if any)
    Map<String, dynamic>? userDetails;
    if (json['user'] is Map) {
      userDetails = Map<String, dynamic>.from(json['user']);
    }
    Map<String, dynamic>? workerDetails;
    if (json['worker'] is Map) {
      workerDetails = Map<String, dynamic>.from(json['worker']);
    }

    return AppointmentModel(
      id: json['_id'] ?? '',
      userId: (json['user'] is Map) ? json['user']['_id'] : (json['user'] ?? ''),
      workerId: (json['worker'] is Map) ? json['worker']['_id'] : (json['worker'] ?? ''),
      jobId: json['job'] is Map ? json['job']['_id'] : (json['job'] ?? ''),
      workTitle: json['workTitle'] ?? '',
      description: json['description'],
      date: json['date'] ?? '',
      time: json['time'],
      requestedWage: (json['requestedWage'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? 'pending',
      cancelReason: json['cancelReason'],
      rejectReason: json['rejectReason'],
      cancelledAt: json['cancelledAt'] != null ? DateTime.parse(json['cancelledAt']) : null,
      rejectedAt: json['rejectedAt'] != null ? DateTime.parse(json['rejectedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      userDetails: userDetails,
      workerDetails: workerDetails,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'worker': workerId,
      'job': jobId,
      'workTitle': workTitle,
      'description': description,
      'date': date,
      'time': time,
      'requestedWage': requestedWage,
      'status': status,
      'cancelReason': cancelReason,
      'rejectReason': rejectReason,
      'cancelledAt': cancelledAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}