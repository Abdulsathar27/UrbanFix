class AppointmentModel {
  final String id;
  final String userId;      // customer id (who requested)
  final String workerId;    // service provider id (who will do the work)
  final String jobId;
  final String workTitle;   // service name
  final String? description;
  final String date;        // "YYYY-MM-DD"
  final String? time;       // "09:00 AM" or null
  final double requestedWage;
  final String status;      // pending, accepted, rejected, cancelled, completed
  final String? cancelReason;
  final String? rejectReason;
  final DateTime? cancelledAt;
  final DateTime? rejectedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional: populated user/worker details
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
    // Handle populated fields (if backend returns populated data)
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
      userId: (json['user'] is Map)
          ? json['user']['_id']
          : (json['user'] ?? ''),
      workerId: (json['worker'] is Map)
          ? json['worker']['_id']
          : (json['worker'] ?? ''),
      jobId: (json['job'] is Map) ? json['job']['_id'] : (json['job'] ?? ''),
      workTitle: json['workTitle'] ?? '',
      description: json['description'],
      date: json['date'] ?? '',
      time: json['time'],
      requestedWage: (json['requestedWage'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? 'pending',
      cancelReason: json['cancelReason'],
      rejectReason: json['rejectReason'],
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'] as String)
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AppointmentModel copyWith({
    String? id,
    String? userId,
    String? workerId,
    String? jobId,
    String? workTitle,
    String? description,
    String? date,
    String? time,
    double? requestedWage,
    String? status,
    String? cancelReason,
    String? rejectReason,
    DateTime? cancelledAt,
    DateTime? rejectedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? userDetails,
    Map<String, dynamic>? workerDetails,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workerId: workerId ?? this.workerId,
      jobId: jobId ?? this.jobId,
      workTitle: workTitle ?? this.workTitle,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      requestedWage: requestedWage ?? this.requestedWage,
      status: status ?? this.status,
      cancelReason: cancelReason ?? this.cancelReason,
      rejectReason: rejectReason ?? this.rejectReason,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userDetails: userDetails ?? this.userDetails,
      workerDetails: workerDetails ?? this.workerDetails,
    );
  }

  @override
  String toString() {
    return 'AppointmentModel(id: $id, status: $status, workTitle: $workTitle, date: $date, time: $time)';
  }
}