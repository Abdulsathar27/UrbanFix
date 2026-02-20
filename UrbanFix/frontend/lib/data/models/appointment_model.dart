class AppointmentModel {
  final String id;
  final String userId;
  final String jobId;
  final String serviceProviderId;
  final DateTime appointmentDate;
  final String timeSlot;
  final String status; // pending, confirmed, completed, cancelled
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.jobId,
    required this.serviceProviderId,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  // ==========================
  // From JSON
  // ==========================
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      jobId: json['jobId'] ?? '',
      serviceProviderId: json['serviceProviderId'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate']),
      timeSlot: json['timeSlot'] ?? '',
      status: json['status'] ?? 'pending',
      notes: json['notes'],
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
      'userId': userId,
      'jobId': jobId,
      'serviceProviderId': serviceProviderId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status,
      'notes': notes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // ==========================
  // Copy With
  // ==========================
  AppointmentModel copyWith({
    String? id,
    String? userId,
    String? jobId,
    String? serviceProviderId,
    DateTime? appointmentDate,
    String? timeSlot,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
      serviceProviderId:
          serviceProviderId ?? this.serviceProviderId,
      appointmentDate:
          appointmentDate ?? this.appointmentDate,
      timeSlot: timeSlot ?? this.timeSlot,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
